import { Project } from "../models/Porject.js";
import { Task } from "../models/Task.js";


const addTask = async (req, res) => {
  const projectId = req.body.projectId;
  const sectionIndex = req.body.sectionIndex;
  const taskData = req.body.taskData;
  const userId = req.userId;

  try {
    const project = await Project.findById(projectId);
    if (!project) {
      return res.status(404).json({ msg: "Project not found" });
    }

    // Check if the user's role is admin or owner
    const member = project.members.find(
      (member) => member.id.toString() === userId
    );
    if (!member || (member.role !== "admin" && member.role !== "owner")) {
      return res.status(403).json({ msg: "Unauthorized access" });
    }

    // Create a new task and assign it to the project
    const task = new Task({
      ...taskData,
      project: projectId,
      isInproject: true,
    });
    console.log(task );
    if (!sectionIndex ) {
      // Add the task to the project's tasks array
      project.tasks.push({task: task ,  });
    } else {
      // Find the section by index
      const section = project.sections.find(
        (sec) => sec.index === sectionIndex
      );
      if (!section) {
        return res.status(400).json({ msg: "Invalid section index" });
      }

      // Add the task to the specified section's tasks array
      task.sectionIndex = sectionIndex;
      section.tasks.push({task : task});
    }

    await project.save();

    return res.status(200).json(task);
  } catch (error) {
    console.log(error);
    return res.status(400).json({ msg: error.message });
  }
};
const removeTaskFromProject = async (req, res) => {
  const projectId = req.body.projectId;
  const taskId = req.body.taskId;
  const userId = req.userId;
  
  try {
    const project = await Project.findById(projectId);
    if (!project) {
      return res.status(404).json({ msg: "Project not found" });
    }
    
    // Check if the user's role is admin or owner
    const member = project.members.find(
      (member) => member.id.toString() === userId
    );
    if (!member || (member.role !== "admin" && member.role !== "owner")) {
      return res.status(403).json({ msg: "Unauthorized access" });
    }
    
    // Find the task by ID
    const taskIndex = project.tasks.findIndex((t) => t.task && t.task._id.toString() === taskId);
    if (taskIndex === -1) {
      return res.status(404).json({ msg: "Task not found" });
    }
    
    // Remove the task from the tasks array
    project.tasks.splice(taskIndex, 1);
    
    await project.save();
    
    return res.status(200).json({ msg: "Task deleted successfully" });
  } catch (error) {
    console.log(error);
    return res.status(400).json({ msg: error });
  }
};

const moveTaskInSection = async (req, res) => {
  const projectId = req.body.projectId;
  const taskId = req.body.taskId;
  const fromSectionIndex = req.body.fromSectionIndex;
  const toSectionIndex = req.body.toSectionIndex;
  const userId = req.userId;

  try {
    const project = await Project.findById(projectId);
    if (!project) {
      return res.status(404).json({ msg: "Project not found" });
    }

    // Check if the user's role is admin or owner
    const member = project.members.find(
      (member) => member.id.toString() === userId
    );
    if (!member || (member.role !== "admin" && member.role !== "owner")) {
      return res.status(403).json({ msg: "Unauthorized access" });
    }

    // Find the "from" section by index
    const fromSection = project.sections.find(
      (sec) => sec.index === fromSectionIndex
    );
    if (!fromSection) {
      return res.status(400).json({ msg: "Invalid 'from' section index" });
    }

    // Find the "to" section by index
    const toSection = project.sections.find(
      (sec) => sec.index === toSectionIndex
    );
    if (!toSection) {
      return res.status(400).json({ msg: "Invalid 'to' section index" });
    }

    // Find the task in the "from" section's tasks array
    const taskIndex = fromSection.tasks.findIndex(
      (task) => task._id.toString() === taskId
    );
    if (taskIndex === -1) {
      return res.status(400).json({ msg: "Task not found in 'from' section" });
    }

    // Remove the task from the "from" section
    const task = fromSection.tasks.splice(taskIndex, 1)[0];

    // Update the section index of the task
    task.sectionIndex = toSectionIndex;

    // Add the task to the "to" section's tasks array
    toSection.tasks.push(task);

    await project.save();

    return res.status(200).json({ msg: "Task moved successfully" });
  } catch (error) {
    return res.status(400).json({ msg: "Failed to move task" });
  }
};
//

const assignTaskToMember = async (req, res) => {
  const projectId = req.body.projectId;
  const sectionIndex = req.body.sectionIndex;
  const taskId = req.body.taskId;
  const memberId = req.body.memberId;
  const userId = req.userId;
  
  try {
    const project = await Project.findById(projectId);
    if (!project) {
      return res.status(404).json({ msg: "Project not found" });
    }

    // Check if the user's role is admin or owner
    const member = project.members.find(
      (member) => member.id.toString() === userId
    );
    console.log(member);
    if (!member || (member.role !== "admin" && member.role !== "owner")) {
      return res.status(403).json({ msg: "Unauthorized access" });
    }

    let task = null;

    if (sectionIndex) {
      // Find the section in the project
      const section = project.sections.find(
        (section) => section.index.toString() === sectionIndex
      );
      if (!section) {
        return res.status(404).json({ msg: "Section not found" });
      }

      // Find the task in the section
      task = section.tasks.find((t) =>t.task &&  t.task._id.toString() === taskId);
      if (!task) {
        return res.status(404).json({ msg: "Task not found in the section" });
      }
    } else {
      // Find the task in the project's tasks array
      task = project.tasks.find((t) =>t.task &&  t.task._id.toString() === taskId);
      if (!task) {
        return res.status(404).json({ msg: "Task not found in the project" });
      }
    }

    // Check if the member exists in the project
    const assignedMember = project.members.find(
      (member) => member.id.toString() === memberId
    );
    if (!assignedMember) {
      return res.status(404).json({ msg: "Member not found in the project" });
    }

    // Assign the task to the member
    task.name = assignedMember.name ; 
    task.role = assignedMember.role; 
    task.id = memberId;
    await project.save();

    return res.status(200).json({ msg: "Task assigned successfully" });
  } catch (error) {
    console.log(error);
    return res.status(400).json({ msg: "Failed to assign task" });
  }
};
const editTask = async (req, res) => {
  const projectId = req.body.projectId;
  const taskId = req.body.taskId;
  const updatedTaskData = req.body.updatedTaskData;
  const userId = req.userId;
  try {
    const project = await Project.findById(projectId);
    if (!project) {
      return res.status(404).json({ msg: "Project not found" });
    }
    // Check if the user's role is admin or owner
    const member = project.members.find(
      (member) => member.id.toString() === userId
    );
    if (!member || (member.role !== "admin" && member.role !== "owner")) {
      return res.status(403).json({ msg: "Unauthorized access" });
    }
    console.log(project.tasks);
    // Find the task by ID
    const task = project.tasks.find((t) => t.task && t.task._id.toString() === taskId);
    if (!task) {
      return res.status(404).json({ msg: "Task not found" });
    }
    Object.assign(task.task , updatedTaskData)
    console.log(task);
    // Update the task with the new data 
    await project.save();
    return res.status(200).json(task);
  } catch (error) {
 console.log(error);
    return res.status(400).json({ msg: error });
  }
};

 
export {addTask, removeTaskFromProject , assignTaskToMember ,editTask, moveTaskInSection }
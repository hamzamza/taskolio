import { User } from "../models/User.js";
import { Project } from "../models/Porject.js";
// creation d'un projet

const createProject = async (req, res) => {
  const projectData = req.body.projectData;
  const userId = req.userId;
  // don't add
  projectData.owner = userId;
  if (!projectData.members) {
    projectData.members = [];
  }
  try {
    const user = await User.findById(userId);

  projectData.members.push({ id: userId, role: "owner", status: "accept" , name : user.username, email : user.email  });

    // Create the project
    const newProject = await Project.create(projectData);
    // Add the project to the user's project list
   
    user.projects.push(newProject._id);
    await user.save();
    res
      .status(200)
      .json({ msg: "Project created successfully", project: newProject });
  } catch (err) {
    res.status(500).json({ msg: err });
  }
};

// add memebers to project

const addMember = async (req, res) => {
  // member to add for test 6461152258334acd6dd2bfd9
  const role = req.body.role;
  const userId = req.userId;
  const guestEmail = req.body.guestEmail;
  const projectId = req.body.projectId;
  const message = req.body.message;
  const user = await User.findById(userId);
  const guestUser = await User.findOne({ email: guestEmail });
  const project = await Project.findById(projectId);

  if (!project) {
    return res.status(404).json({ msg: "Project not found" });
  }

  if (project.owner.toString() !== userId) {
    return res.status(403).json({ msg: "Unauthorized access" });
  }

  // Check if the guest user exists
  if (!guestUser) {
    return res.status(404).json({ msg: "Guest user not found" });
  }

  // Check if the guest user is already a member of the project
  const existingMember = project.members.find(
    (member) => member.id.toString() === guestUser._id.toString()
  );

  if (existingMember) {
    return res
      .status(400)
      .json({ msg: "Guest user is already a member of the project" });
  }

  // Add the guest user as a member with a default role and status
  project.members.push({
    id: guestUser._id,
    name : guestUser.username , 
    email : guestUser.email , 
    role: "member", // Set the desired role here
    status: "pending", // Set the desired status here
  });

  guestUser.invitations.push({
    role: role,
    projectid: projectId,
    projectTitle: project.title,
    ownerName: user.username,
    message: message,
  });

  await guestUser.save();
  await project.save();
  return res.status(200).json({ msg: "Member added successfully" });
};
const removeMember = async (req, res) => {
  const projectId = req.body.projectId;
  const memberId = req.body.memberId;
  const userId = req.userId;
  try {
    // Delete from project
    const project = await Project.findById(projectId);
    if (!project) {
      return res.status(404).json({ msg: "Project not found" });
    }
    // Check if the user is the owner of the project
    if (project.owner.toString() !== userId) {
      return res.status(403).json({ msg: "Unauthorized access" });
    }
    // Find the index of the member to be removed
    const memberIndex = project.members.findIndex(
      (member) => member.id.toString() === memberId
    );
    if (memberIndex === -1) {
      return res.status(404).json({ msg: "Member not found" });
    }
    // Remove the member from the project's members array
    project.members.splice(memberIndex, 1);
    // Save the updated project
    await project.save();

    // Delete from user's projects list
    const user = await User.findById(memberId);
    if (!user) {
      return res.status(404).json({ msg: "User not found" });
    }
    const projectIndex = user.projects.findIndex(
      (pr) => pr.toString() === projectId
    );
    if (projectIndex === -1) {
      return res.status(404).json({ msg: "Project not found in user's projects" });
    }
    user.projects.splice(projectIndex, 1);
    await user.save();

    res.status(200).json({ msg: "Member removed successfully", project });
  } catch (err) {
    res.status(500).json({ msg: "Failed to remove the member" });
  }
};

const response = async (req, res) => {
  const userId = req.userId;
  const invitationId = req.body.invitationId;
  const response = req.body.response; // true or false
  // if true change something
  // else don't do nothing
  if (response == false) {
    return res.status(202).json({ msg: "ok joining doesn't accepted " });
  }
  const user = await User.findById(userId);

  // Find the invitation in the user's invitations array
  const invitation = user.invitations.find(
    (invite) => invite._id.toString() === invitationId
  );

  if (!invitation) {
    return res.status(404).json({ msg: "Invitation not found" });
  }

  // Find the corresponding project based on the invitation's projectid
  const project = await Project.findById(invitation.projectid);

  if (!project) {
    return res.status(404).json({ msg: "Project not found" });
  }

  // Check if the user is already a member of the project
  const existingMember = project.members.find(
    (member) => member.id.toString() === userId && member.status == "accept"
  );

  if (existingMember) {
    return res
      .status(400)
      .json({ msg: "User is already a member of the project" });
  }
  const existingPendingIndex = project.members.findIndex(
    (member) =>
      member.id.toString() === userId && member.status === "pending"
  );

  if (existingPendingIndex !== -1) {
    project.members.splice(existingPendingIndex, 1);
  }

  project.members.push({
    id: userId,
    email : user.email , 
    name : user.username , 
    role: invitation.role,
    status: "accept",
  });

  user.invitations = user.invitations.filter(
    (invite) => invite._id.toString() !== invitationId
  );
  user.projects.push(invitation.projectid);
  await project.save();
  await user.save();
  return res.status(200).json({ msg: "Invitation accepted successfully" });
};


const editProject = async (req, res) => {
  const projectId = req.params.projectId;
  const updatedProjectData = req.body.updatedProjectData;
  const userId = req.userId;

  try {
    // Find the project
    const project = await Project.findById(projectId);

    if (!project) {
      return res.status(404).json({ msg: "Project not found" });
    }

    // Check if the user is the owner of the project
    if (project.owner.toString() !== userId) {
      return res.status(403).json({ msg: "Unauthorized access" });
    }

    // Update the project data
    if (updatedProjectData.title !== null) {
      project.title = updatedProjectData.title;
    }
    if (updatedProjectData.them != null) {
      project.them = updatedProjectData.them;
    }
    if (updatedProjectData.description !== null) {
      project.description = updatedProjectData.description;
    }
    // Update other project properties as needed

    // Save the updated project
    await project.save();

    res.status(200).json({ msg: "Project updated successfully", project });
  } catch (err) {
    res.status(500).json({ msg: "Failed to update the project" });
  }
};

// delete projet by the owner
const deleteProject = async (req, res) => {
  const projectId = req.body.projectId;
  const userId = req.userId;
  try {
    // Check if the user is the owner of the project
    const project = await Project.findById(projectId);
    if (!project) {
      return res.status(404).json({ msg: "Project not found" });
    }

    if (project.owner.toString() !== userId) {
      return res.status(403).json({ msg: "Unauthorized access" });
    }

    // Delete the project
    await project.remove();

    // Remove the project from all users' project lists
    await User.updateMany(
      { projects: projectId },
      { $pull: { projects: projectId } }
    );

    res.status(200).json({ msg: "Project deleted successfully" });
  } catch (err) {
    res.status(500).json({ msg: "Failed to delete the project" });
  }
};

// Synchronization function for projects

const getProjects = async (req, res) => {
  try {
    const userId = req.userId;
    const user = await User.findById(userId).populate({
      path: "projects",
      populate: {
        path: "tasks.task",
        model: "Task",
      },
    });
    res.status(200).json(user.projects);
  } catch (error) {
    res.status(500).json({ msg: "Can't find any projects for this user" });
  }
};

export { getProjects, createProject, addMember,removeMember ,  response };

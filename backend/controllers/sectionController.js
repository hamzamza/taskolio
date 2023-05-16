import { Project } from "../models/Porject.js";
import  generateShortUUID  from './generateid.js';
 
const createSection = async (req, res) => {
  // generate randome index
  const index =   generateShortUUID();
  const userId = req.userId;
  const projectId = req.body.projectId;
  const sectionData = req.body.sectionData;

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
    project.sections.push({index : index , ...sectionData }); 
    await project.save();
    return res.status(200).json({index : index , ...sectionData });
  } catch (error) {
    console.log(error);
    return res.status(400).json({ msg: error.message });
  }
};
export {createSection }
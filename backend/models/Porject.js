import mongoose from "mongoose"; 

import { Task, taskSchema } from "./Task.js";
import { sectionSchema } from "./Section.js";

const projectSchema = new mongoose.Schema({
  
  owner: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
  }, 
  title: { type: String, required: true },
  desc: { type: String },
  them: { type: Number, default: 0 },
  members: {
    type: [
      {
        id: {
          type: mongoose.Schema.Types.ObjectId,
          ref: "User",
        },
        name  : String , 
        email : String ,
        role: { type: String, enum: ["owner", "member", "admin"] },
        status: { type: String, enum: ["pending", "accept", "leaving"] , default: "pending" },
        // pending or accept or  leaved 
      },
    ],
    default: [],
  },
  archived: { type: Boolean, default: false },
  tasks: {
    type: [
      {
        task:  {type : taskSchema    } , 
        role : String , 
        name : String , 
        id: {
          type: mongoose.Schema.Types.ObjectId,
          ref: "User",
        },
      },
    ],
    default : []
   
  },
  sections: {
    type: [sectionSchema],
    default: [
      { index: "0", title: "Todo" },
      { index: "1", title: "Doing" },
      { index: "2", title: "Done" },
    ],
  },
});

const Project = mongoose.model("Project", projectSchema);

export { Project, projectSchema };

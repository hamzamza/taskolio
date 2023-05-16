import mongoose from "mongoose";
import { taskSchema } from "./Task.js";

const sectionSchema = new mongoose.Schema({
  index: { type: String, required: true },
  title: { type: String, required: true },
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
});

 
export {   sectionSchema };
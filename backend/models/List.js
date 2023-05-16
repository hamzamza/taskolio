import mongoose from "mongoose";
import { taskSchema } from "./Task.js";

const listSchema = new mongoose.Schema(
  {
    id: { type: String, required: true },
    title: { type: String, required: true },
    desc: { type: String,  },
    icon: { type: String,  },
    color: { type: Number, default: 0 },
    tasks: {
      type: [taskSchema],
      default: [],
    },
  }
);

 
export {  listSchema };
import mongoose from "mongoose";
import { SubtaskSchema } from "./Subtasks.js";

const taskSchema = new mongoose.Schema({
  id: { type: String, required: true },
  title: { type: String, required: true },
  desc: { type: String },
  isTimed: { type: Boolean, default: false },
  start: { type: Date },
  end: { type: Date },
  dueDate: { type: Date },
  isRepeated: { type: Boolean, default: false },
  repetationType: { type: String },
  repetations: { type: [String] },
  reminder: { type: Boolean, default: false },
  reminderInterval: { type: Number },
  progress: { type: Number, min: 0, max: 100 },
  isDone: { type: Boolean, default: false },
  preority: { type: Number },
  favorite: { type: Boolean, default: false },
  bin: { type: Boolean, default: false },
  isInproject: { type: Boolean, default: false },
  projectId: { type: String },
  sectionIndex: { type: String },
  assignedtoId: { type: String },
  isInCategory: { type: Boolean, default: false },
  categorieId: { type: String },
  subtasks: { type: [SubtaskSchema] },
});

 
const Task = mongoose.model("task", taskSchema);

export {  Task , taskSchema };

import mongoose from "mongoose";

const SubtaskSchema = new mongoose.Schema({
  id: { type: String, required: true },
  title: { type: String, required: true },
  desc: { type: String },
  isTimed: { type: Boolean, default: false },
  start: { type: Date },
  end: { type: Date },
  dueDate: { type: Date },
  reminder: { type: Boolean, default: false },
  reminderInterval: { type: Number },
  progress: { type: Number, min: 0, max: 100 },
  isDone: { type: Boolean, default: false },
  preority: { type: Number },
  favorite: { type: Boolean, default: false },
  bin: { type: Boolean, default: false },
  
});

 

export {  SubtaskSchema };

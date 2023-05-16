import mongoose from "mongoose";
import { taskSchema } from "./Task.js";
import { categroySchema } from "./Category.js";

import { listSchema } from "./List.js";
const userSchema = new mongoose.Schema({
  username: {
    type: String,
    required: true,
    unique: true,
  },
  password: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: true,
    unique: true,
  },
  imgUrl: {
    type: String,
    default:
      "https://avatar-management--avatars.us-west-2.prod.public.atl-paas.net/default-avatar.png",
  },
  tasks: {
    type: [taskSchema],
    default: [],
  },
  categories: {
    type: [categroySchema],
    default: [],
  },
  invitations: {
    type: [
      {
        role: { type: String, enum: ["owner", "member", "admin"] , default: "admin" },
       
        projectid: { type: String, required: true },
        projectTitle: { type: String, required: true },
        ownerName: { type: String, required: true },
        message: { type: String, default: "join me on my project ! " },
        accepted: Boolean,
      },
    ],
    default: [],
  },
  lists: {
    type: [listSchema],
    default: [],
  },
  projects: {type : [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Project",
    },
    
  ], default:[]} ,
  bin: {
    type: [taskSchema],
    default: [],
  },
  important: {
    type: [taskSchema],
    default: [],
  },
});
const User = mongoose.model("User", userSchema);
export { User, userSchema };

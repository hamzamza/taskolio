import mongoose from "mongoose"
import { taskSchema } from "./Task.js";
const categroySchema = new mongoose.Schema(
    {
        id: { type: String, requiredd: true },
        title: { type: String, required: true },
        desc: { type: String, },
        icon: { type: String, }
        , color: { type: Number, defalut: 0 },
        tasks: {
            type: [taskSchema],
            default: []
        },
    }
)


 
export {   categroySchema };
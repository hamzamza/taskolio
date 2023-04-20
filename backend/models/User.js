import mongoose from "mongoose"
import { TaskSchema } from "./Task.js"
const UserSchema = new mongoose.Schema(

    {
        username: {
            type: String,
            required: true,
            unique: true
        }
        ,
        password: {
            type: String,
            required: true,
        }
        ,
        email: {
            type: String,
            required: true
            , unique: true
        }
        ,
        imgUrl : {
            type: String, 
            default :"https://avatar-management--avatars.us-west-2.prod.public.atl-paas.net/default-avatar.png"
        }
        , 
        tasks : {
           type :  [TaskSchema] , 
           default:[]
    }
}

)

export default mongoose.model("User" , UserSchema)
import mongoose from "mongoose"
const TaskSchema = new mongoose.Schema(

    {
        title : {
             type : String ,
             required : true
             } , 

        text : {
              type : String, 
              required : true   
        }, 
        start : {
            type : Date , 
         } , 
        end : {
            type : Date
         }  , 
        color : {
            type : String
        }, 
        imgurl : {
            type : String
         },
        categoried : {
            type : Boolean
         }   , 
        category : {
            type: mongoose.Schema.Types.ObjectId,
            ref: "Categrory", 
         },
         bin:{
            type:Boolean,
            default:false 
         },
        done : {type  : Boolean } 
    }

)

const Task =  mongoose.model("Task" , TaskSchema) 
export    { Task   , TaskSchema  }

import mongoose from "mongoose"
const categroySchema = new mongoose.Schema(
    {
        title: { type: String, required: true },
        desc: { type: String, required: true },
        userId:{ 
            type: mongoose.Schema.Types.ObjectId,
            ref: "User",  
         },
        imgurl: { type: String, default: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Blank_Square.svg/768px-Blank_Square.svg.png" },
        color: { type: String, defalut: "1" } 

    }

)


export default mongoose.model("Categrory", categroySchema);
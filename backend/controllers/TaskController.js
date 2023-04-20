import User from "../models/User.js";



const updateTasks = async (req, res, next) => {
    const newtasks = req.body;
    console.log('the body is :',newtasks)
    try {

        await User.findOne({ _id:req.user }).then(async (user) => {
            if(user){
                console.log('user found')
                user.tasks = newtasks;
                await User.updateOne(user,{new :true});
                res.status(200).json({ msg: "everything uptodate" })
            }
        

        }).catch((error) => {
            if (error) {
                console.log(error);
                res.status(500).json({ msg: "bad" })

                return;
            }
        })

    } catch (error) {
        console.log(error);
        res.status(500).json({ msg: error })
    }
}

const updateTask=async(req,res,next)=>{
      User.findOneAndUpdate({
          _id:req.user,
          "tasks._id": req.params.taskId 
     }, { $set  :{ "tasks.$.bin":req.params.bin} },
        {new :true}
         ).then((result)=>{
            if(result){
                return res.status(200).send('the task has been updated succefly')
            }
         }).catch((error)=>{
                return res.status(200).send(error)
         })
}
const getTasks = async (req, res) => {

    const user=await User.findOne(
        {    
            _id:req.user,  
            tasks: { 
                $elemMatch: {
                    category:req.params.catId,
                    bin:false
                  }
             } 
         }
        )
     if(user?.tasks){
        return res.status(200).json(user.tasks);
     }
     else{
        return res.status(200).json([]); 
     } 

}



const addTask = async (req, res) => {
    console.log('hello in add task')
    const newTask = req.body
    console.log('req body is',req.body)
    await User.findOneAndUpdate(
        { _id: req.user }, 
        { $push: { tasks: newTask } },
        { new: true }).then(
            (updatedUser) => {
                console.log(updatedUser);
                res.status(200).json(updatedUser)
            })
}
const getBinTasks=async (req,res)=>{
    console.log('hello in get Bin tasks')
      await User.findOne( 
        { 
            _id:req.user,
           tasks: {
                $elemMatch: { 
                    bin:true
                  }
            },
         } 
        )
         .then((user)=>{
                  if(user?.tasks){
                    return res.status(200).json(user.tasks);
                   }
                 else{
                    return res.status(200).json([]); 
                 }
                  
         }).catch((error)=>{
             res.status(400).send(error)
         }) 
}
const deleteTask = async (req, res) => {
    await User.findByIdAndUpdate({ _id: req.user }, { $pull: { tasks: { _id: req.params.taskId } } } , {new : true} ).then((newuser)=>{
        res.status(200).json(newuser)
    }).catch((error)=>{
        res.status(400).jsont({msg : error.msg})
    })

}


export { updateTasks, getTasks, addTask, deleteTask,getBinTasks,updateTask };
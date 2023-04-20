import Category from "../models/Category.js"
const getCategories=async (req,res,next)=>{
   console.log('hello in get categorie')
    
    Category.find({ userId:req.user })
     .exec().then(function(result){
          if(result){
             res.status(200).json(result)
          }
          else{
            res.send('there is no categorie')
          }
     }).catch((error)=>{
        res.send(error)
     })
    
}
const addCategorie=async (req,res,next)=>{
     const categorie={
        title:req.body.title,
        desc:req.body.desc,
        userId:req.user,
        color:req.body.color
     }
     if(req.file){
        categorie.imgurl=req.file.filename
     }
     const categorieData=new Category(categorie)
     categorieData.save().then((result)=>{
        if(result){
            return res.status(200).json(result)
        }
    
     }).catch((error)=>{
        res.status(400).send(error)
     })
     
}
const deleteCategorie=async(req,res,next)=>{
   Category.findByIdAndRemove({_id:req.params.id})
    .then((result)=>{
       res.send(result)
    }).catch((error)=>{
      res.send(error)
    })

}
const getCategoryById=async(req,res,next)=>{
    Category.findById({ _id:req.params.catId,userId: req.user })
       .then((cat)=>{
              return res.status(200).json(cat)
       }).catch((error)=>{
              return res.status(400).send(error)
       })
}

export   { getCategories, addCategorie, deleteCategorie, getCategoryById }

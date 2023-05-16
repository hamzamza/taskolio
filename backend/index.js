import express from 'express'
import connectDb from './db/conection.js';
import dotenv from "dotenv"
import authRouter from  "./routes/authRoute.js"
import CatRouter from './routes/categoryRoute.js'; 
import TaskRouter from './routes/tasksRoute.js'
import listRouter from './routes/listRoute.js'
import BinRouter from './routes/binRoute.js'
import importantRouter from './routes/importantRoute.js'
import ProjectRouter from './routes/projectRoute.js'
 import projectSectionRouter from "./routes/projectSectionRouter.js"
import projectTaskRouter  from './routes/projectTaskRouter.js'
 dotenv.config()
console.log('\x1b[0m',"");

 console.log('\x1b[34m' ,"start server --------------------------------------------------------------");
console.log('\x1b[0m',"");
const  app = express();
app.use(express.json());



const port = process.env.PORT  || 5000 ;
const url = process.env.URL ; 



app.use('/api/auth'  , authRouter )
app.use('/api/category', CatRouter) 
app.use('/api/lists' , listRouter) 
app.use('/api/tasks', TaskRouter)
app.use('/api/bin', BinRouter)
app.use('/api/important', importantRouter)
app.use('/api/project', ProjectRouter)
app.use('/api/project/task' , projectTaskRouter)
app.use('/api/project/section' , projectSectionRouter)

app.listen(port ,   ()=>{
 connectDb(url)
  console.log(`the app is listening in the port  http://localhost:${port}/`) ;
console.log('\x1b[0m',"");

console.log('\x1b[34m' , "change something to rerender server -----------------------------------------------");
console.log('\x1b[0m',"");

})


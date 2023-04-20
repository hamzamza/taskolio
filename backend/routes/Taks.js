import express from 'express'
 
import {updateTasks , getTasks, addTask, deleteTask, getBinTasks,updateTask } from '../controllers/TaskController.js'
import verifyToken from '../midllware/tokenverification.js'
const router  = express.Router() 
 router.route('/updateTask' ).post( verifyToken , updateTasks)
 router.route('/getTasks/:catId').get(verifyToken , getTasks ) 
 router.route('/getBinTasks').get(verifyToken ,getBinTasks)
 router.route('/addtask').post(verifyToken , addTask)
 router.route('/deletTask/:taskId').delete(verifyToken , deleteTask) ;
 router.route('/updateTask/:taskId/:bin').put( verifyToken, updateTask ) 
export default router  
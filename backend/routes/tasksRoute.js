import express from 'express'
 
import {updateTasks , getTasks } from '../controllers/TaskController.js'
import {verifyToken} from '../midllware/tokenverification.js'
const router  = express.Router() 
router.route('/').get( verifyToken, getTasks ) 
 router.route('/update' ).post( verifyToken , updateTasks)
export default router  
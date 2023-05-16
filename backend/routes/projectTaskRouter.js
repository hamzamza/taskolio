import express from 'express'
 import {addTask, removeTaskFromProject, assignTaskToMember ,editTask, moveTaskInSection } from  '../controllers/projectTasksController.js'
import { verifyToken } from '../midllware/tokenverification.js'
const router=express.Router() 
router.route('/create').post( verifyToken, addTask )
router.route('/update').post(verifyToken,  editTask )
router.route('/delte').delete(  verifyToken,  removeTaskFromProject )
router.route('/assigne').post(verifyToken, assignTaskToMember)
router.route('/move').post(verifyToken , moveTaskInSection)
export default router 

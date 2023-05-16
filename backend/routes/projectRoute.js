import express from 'express'
import { createProject, getProjects  , addMember  ,response, removeMember } from '../controllers/projectController.js'
import projectTaskRouter  from '../routes/projectTaskRouter.js'
import {verifyToken} from '../midllware/tokenverification.js'
const router=express.Router() 
router.route('/').get( verifyToken,getProjects )
router.route('/create').post( verifyToken,createProject )
router.route('/addMember').post( verifyToken,addMember )
router.route('/removeMember').delete(verifyToken,removeMember)
router.route('/response').post(verifyToken, response)
 



export default router 
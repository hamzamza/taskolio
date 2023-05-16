import express from 'express'
 import {createSection } from  '../controllers/sectionController.js'
import { verifyToken } from '../midllware/tokenverification.js'
const router=express.Router() 
router.route('/create').post( verifyToken, createSection )
 
export default router 

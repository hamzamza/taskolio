import express from 'express'
import { getCategories,  updateCategories  } from '../controllers/categoryController.js'
import {verifyToken} from '../midllware/tokenverification.js'
const router=express.Router() 
router.route('/').get( verifyToken,getCategories )
router.route('/update').post( verifyToken,updateCategories  ) 
 
export default router 
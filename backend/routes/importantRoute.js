import express from 'express'
 
import {updateImportant , getImportant } from '../controllers/importantController.js'
import {verifyToken} from '../midllware/tokenverification.js'
const router  = express.Router() 
router.route('/').get( verifyToken, getImportant ) 
 router.route('/update' ).post( verifyToken , updateImportant)
export default router  
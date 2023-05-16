import express from 'express'
 
import {updateBin , getBin } from '../controllers/binController.js'
import {verifyToken} from '../midllware/tokenverification.js'
const router  = express.Router() 
router.route('/').get( verifyToken, getBin ) 
 router.route('/update' ).post( verifyToken , updateBin)
export default router  
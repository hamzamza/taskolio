import express from 'express';
import { getLists, updateLists } from '../controllers/listsController.js';
import {verifyToken} from '../midllware/tokenverification.js'

const router = express.Router();
router.get('/', verifyToken, getLists);
router.post('/update', verifyToken, updateLists);
export default router;
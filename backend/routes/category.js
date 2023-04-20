import express from 'express'
import { getCategories,addCategorie,deleteCategorie, getCategoryById  } from '../controllers/category.js'
import verifyToken from '../midllware/tokenverification.js'
const router=express.Router() 

router.route('/getCategories').get( verifyToken,getCategories  ) 
router.route('/addCategorie').post( verifyToken,addCategorie )
router.route('/deletCategorie/:id').post( deleteCategorie )
router.route('/getCatById/:catId').get( verifyToken,getCategoryById )
export default router 
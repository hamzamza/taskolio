import User from "../models/User.js"
import jwt from 'jsonwebtoken'




const verifyToken = async (req, res, next) => {
    const token = req.headers.authorization;
    console.log('token: ',token)
    let decodedToken;
    try { 
        const secret = process.env.SECRET;
        decodedToken = jwt.verify(token, secret);
        console.log(decodedToken);
        const userId = decodedToken.userId;
        const userflan = await User.findById(userId);
        if (userflan) {
            req.user =userId
            console.log(userflan);
        }
        else throw Error()
    } catch (error) {
        return false;
    }
    next()
}


export  default verifyToken
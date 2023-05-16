import { User } from "../models/User.js"
import jwt from 'jsonwebtoken'





const generatewebtoken = (userId, username) => {
    const payload = {
        userId: userId,
        username: username
    };
    const secret = process.env.SECRET;
    const options = { expiresIn: '30d' }
    return jwt.sign(payload, secret, options);
}



const verifyToken = async (req, res, next) => {
    const token = req.headers.authorization;

    let decodedToken;
    try {
        const secret = process.env.SECRET;
        decodedToken = jwt.verify(token, secret);

        const userId = decodedToken.userId;
        const userflan = await User.findById(userId);
        if (userflan) {
            req.userId = userId
        
        }
        else throw Error()
    } catch (error) {
        return false;
    }
    next()
}


export { verifyToken, generatewebtoken }
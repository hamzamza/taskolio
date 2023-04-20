import User from "../models/User.js"
import jwt from 'jsonwebtoken'
const register = async (req, res, next) => {
    try {
        await User.create({
            username: req.body.username,
            password: req.body.password,
            email: req.body.email
        })
        res.status(203).json()
    } catch (error) {
        console.log(error);
        res.status(500).json({ msg: "bad request " })
    }
}






const login = async (req, res, next) => {
    console.log('hello to login email ',req.body.email," password: ",req.body.password)
   try {
    const user = await User.findOne({ username: req.body.username }
        )
        if (user) {
            const isPasswordcorrect = user._doc.password === req.body.password
            if (isPasswordcorrect) {
                console.log("logged in ");
                const token = generatewebtoken(user._doc._id, req.body.username);
                console.log(token);
                res.status(200).json({token : token,user})
            }
            else res.status(500).json({ msg: "username or password incorrect " })
        }
        else res.status(500).json({ msg: "username or password incorrect " })
   } catch (error) {
    console.log("error : "+ error);
   }
}




const generatewebtoken = (userId, username) => {
    const payload = {
        userId: userId,
        username: username
    };
    const secret = process.env.SECRET;
    const options = { expiresIn: '30d' }
    return jwt.sign(payload, secret, options);
}





const verifyToken = async (token) => {
    let decodedToken;
    try { 
            tokengetted
            const secret = process.env.SECRET;
            decodedToken = jwt.verify(token, secret);
            console.log(decodedToken);
            const userId = decodedToken.userId;
            const userflan = await User.findById(userId); 
        if (userflan) {
            if (userflan._doc.username == decodedToken.username) {
                return true;
            }
        }
    } catch (error) {
        return false;
    }
}



export { register, login, verifyToken } 


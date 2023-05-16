import mongoose from "mongoose"; 

const connectDb = async (url) => {
    try {
        const connct = mongoose.connect(url)
        console.log("connected to data base");
        return connct
        
    } catch (error) {
        console.log(error);
    }
}
export default connectDb;


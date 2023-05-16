import { User } from "../models/User.js";

const updateBin = async (req, res, next) => {
  const newTasks = req.body.bin;
  try {
    const user = await User.findByIdAndUpdate(req.userId, { bin: newTasks });

    res.status(200).json({ msg: "everything is updated" });
  } catch (error) {
    console.log(error);
    res.status(500).json({ msg: "Internal server error" });
  }
};

const getBin = async (req, res) => {
  try {
    const user = await User.findById(req.userId);
    if (user && user.tasks) {
      return res.status(200).json(user.bin);
    } else {
      return res.status(200).json([]);
    }
  } catch (error) {
    console.log(error);
    return res.status(500).json({ msg: "Internal server error" });
  }
};

export { updateBin, getBin };

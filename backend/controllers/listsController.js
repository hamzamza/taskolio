import {User} from "../models/User.js";

const updateLists = async (req, res, next) => {
  const newLists = req.body.lists;
  try {
    await User.findByIdAndUpdate(req.userId, { lists: newLists });
    res.status(200).json({ msg: "Lists updated successfully" });
  } catch (err) {
    res.status(500).json({ msg: "Failed to update user's lists" });
  }
};

const getLists = async (req, res, next) => {
  try {
    const user = await User.findById(req.userId);
    res.status(200).json(user.lists);
  } catch (error) {
    res.status(500).json({ msg: "Error retrieving lists" });
  }
};

export { getLists, updateLists };

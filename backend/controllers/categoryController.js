import {User} from "../models/User.js";

const updateCategories = async (req, res, next) => {
  const newCategories = req.body.categories;
  console.log(newCategories);
  try {
    await User.findByIdAndUpdate(req.userId, { categories: newCategories });
    res.status(200).json({ msg: "Updated successfully" });
  } catch (err) {
    res.status(500).json({ msg: "Failed to update user's categories" });
  }
};

const getCategories = async (req, res, next) => {
  try {
    const user = await User.findById(req.userId);
    res.status(200).json(user.categories);
  } catch (error) {
    res.status(500).json({ msg: "Error retrieving categories" });
  }
};

export { getCategories, updateCategories };
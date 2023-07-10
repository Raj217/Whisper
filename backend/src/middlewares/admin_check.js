import UserModel from "../models/user_model.js";
import { ExceptionCodes } from "../utils/exception.js";

export const adminCheck = async (req, res, next) => {
  const user = await UserModel.findOne({ email: req.body.loggedInUser.email });
  if (!user) {
    return res
      .status(ExceptionCodes.NOT_FOUND)
      .send("User not found, might be deleted");
  } else if (user.admin === false) {
    return res.status(ExceptionCodes.UNAUTHORIZED).send("Not enough privilege");
  }
  return next();
};

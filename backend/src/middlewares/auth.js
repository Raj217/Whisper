import jwt from "jsonwebtoken";
import { ExceptionCodes } from "../utils/exception.js";

if (process.env.JWT_SECRET === undefined) {
  console.log("Couldn't find token key");
}

export const verifyToken = (req, res, next) => {
  const token = req.headers["authorization"];

  if (!token) {
    return res
      .status(ExceptionCodes.FORBIDDEN)
      .send("Token is required for verification");
  }
  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.body.loggedInUser = decoded;
    if (!decoded.emailVerified)
      return res
        .status(ExceptionCodes.UNAUTHORIZED)
        .send({ message: "Email not verified" });
  } catch (err) {
    console.log(err);
    return res
      .status(ExceptionCodes.UNAUTHORIZED)
      .send({ message: "Invalid Token" });
  }
  return next();
};

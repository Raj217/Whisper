import { JwtPayload, verify } from "jsonwebtoken";
import { ExceptionCodes } from "../utils/error.js";
import { NextFunction, Request, Response } from "express";

if (process.env.JWT_SECRET === undefined) {
  console.log("Couldn't find token key");
}

export const verifyToken = (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const token = req.headers["authorization"];

  if (!token) {
    return res
      .status(ExceptionCodes.FORBIDDEN)
      .send("Token is required for verification");
  }
  try {
    const decoded = verify(token, process.env.JWT_SECRET!) as JwtPayload;
    req.body.loggedInUser = decoded;
    if (!decoded.isEmailVerified)
      return res.status(ExceptionCodes.UNAUTHORIZED).send("Email not verified");
  } catch (err) {
    return res.status(ExceptionCodes.UNAUTHORIZED).send("Invalid Token");
  }
  return next();
};

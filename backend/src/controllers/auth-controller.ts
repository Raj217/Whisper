import { NextFunction, Request, Response } from "express";
import * as AuthService from "../services/auth/index.js";
import Exception, { ExceptionCodes } from "../utils/error.js";
import User from "../interfaces/user.js";

export const signUp = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  AuthService.signUp(req.body)
    .then(() => {
      res.status(ExceptionCodes.CREATED).json({
        message:
          "Welcome aboard, A verification mail has been sent to your mail",
      });
    })
    .catch((err: Exception) => {
      next(err);
    });
};

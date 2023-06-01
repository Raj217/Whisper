import { ExceptionCodes } from "../utils/error.js";
import { Request, Response, NextFunction } from "express";

export const welcome = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  return res
    .status(ExceptionCodes.REQUEST_FULFILLED)
    .json({ message: `Welcome to whisper API v-${process.env.VERSION}`  });
};

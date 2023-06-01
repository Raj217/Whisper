import { NextFunction } from "express";
import Exception, { ExceptionCodes } from "../utils/error.js";
import { Request, Response } from "express";

export const defaultExceptionHandler = (
  err: Exception,
  req: Request,
  res: Response,
  next: NextFunction
) => {
  if (res.headersSent) {
    return next(err);
  }

  console.error(err.stack);
  let statusCode = ExceptionCodes.INTERNAL_SERVER_ERROR;
  let message = "Unknown error";
  if (err instanceof Exception) {
    console.log(err);
    statusCode = err.statusCode;
    message = err.message;
  }
  res.status(statusCode).send({ statusCode: statusCode, message: message });
};

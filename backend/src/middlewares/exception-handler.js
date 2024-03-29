import { AxiosError } from "axios";
import Exception, { ExceptionCodes } from "../utils/exception.js";

export const defaultExceptionHandler = (err, req, res, next) => {
  if (res.headersSent) {
    return next(err);
  }

  console.error(err.stack);
  let statusCode = ExceptionCodes.INTERNAL_SERVER_ERROR;
  let message = "Unknown error";
  if (err instanceof Exception) {
    console.error(err);
    statusCode = err.statusCode;
    message = err.message;
  }
  if (typeof message != "object") {
    message = { message: message };
  }
  res.status(statusCode).send(message);
};

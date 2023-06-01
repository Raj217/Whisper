import { ExceptionCodes } from "../utils/error.js";

export const welcome = async (req, res, next) => {
  return res
    .status(ExceptionCodes.REQUEST_FULFILLED)
    .json({ message: `Welcome to whisper API v-${process.env.VERSION}` });
};

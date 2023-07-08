import { ExceptionCodes } from "../utils/error.js";

export const welcome = async (req, res, next) => {
  const { VERSION } = process.env;
  
  const welcomeMessage = {
    messgae: `
    Welcome to whisper API v-${VERSION}
    Current date - ${new Date()}
    `,
  };
  return res.status(ExceptionCodes.REQUEST_FULFILLED).json(welcomeMessage);
};

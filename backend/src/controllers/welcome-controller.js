import { ExceptionCodes } from "../utils/exception.js";
import * as WelcomeService from "../services/welcome/index.js";

export const welcome = async (req, res, next) => {
  WelcomeService.welcome()
    .then((body) => {
      res.status(ExceptionCodes.REQUEST_FULFILLED).json(body);
    })
    .catch((err) => {
      next(err);
    });
};

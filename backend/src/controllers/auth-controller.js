import * as AuthService from "../services/auth/index.js";
import { ExceptionCodes } from "../utils/error.js";

export const signUp = async (req, res, next) => {
  AuthService.signUp(req.body)
    .then((body) => {
      res.status(ExceptionCodes.CREATED).json(body);
    })
    .catch((err) => {
      next(err);
    });
};

export const signIn = async (req, res, next) => {
  AuthService.signIn(req.body)
    .then((body) => {
      res.status(ExceptionCodes.CREATED).json(body);
    })
    .catch((err) => {
      next(err);
    });
};

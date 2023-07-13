import * as AuthService from "../services/auth/index.js";
import { ExceptionCodes } from "../utils/exception.js";

export const googleSignIn = async (req, res, next) => {
  AuthService.googleSignIn(req.body)
    .then((body) => {
      res.status(ExceptionCodes.CREATED).json(body);
    })
    .catch((err) => {
      next(err);
    });
};

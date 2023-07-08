import * as AuthService from "../services/auth/index.js";
import { ExceptionCodes } from "../utils/error.js";

export const googleSignIn = async (req, res, next) => {
  AuthService.googleSignIn(req.body.idToken)
    .then((body) => {
      res.status(ExceptionCodes.CREATED).json(body);
    })
    .catch((err) => {
      next(err);
    });
};

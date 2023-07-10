import { ExceptionCodes } from "../utils/exception.js";
import * as DataServices from "../services/data/index.js";

export const add = (req, res, next) => {
  DataServices.add(req.query)
    .then((body) => res.status(ExceptionCodes.REQUEST_FULFILLED).json(body))
    .catch((err) => {
      next(err);
    });
};

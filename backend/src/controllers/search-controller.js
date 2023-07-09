import { ExceptionCodes } from "../utils/error.js";
import * as SearchServices from "../services/search/index.js";

export const search = (req, res, next) => {
  SearchServices.search(req.query)
    .then((body) => res.status(ExceptionCodes.REQUEST_FULFILLED).json(body))
    .catch((err) => {
      next(err);
    });
};

import * as SerachServices from "../services/search/index.js";
import { ExceptionCodes } from "../utils/exception.js";

export const search = (req, res, next) => {
  SerachServices.search(req.query, req.body.loggedInUser, res.pagination)
    .then((body) => res.status(ExceptionCodes.REQUEST_FULFILLED).json(body))
    .catch((err) => {
      next(err);
    });
};

import * as ContentController from "../services/content/index.js";
import { ExceptionCodes } from "../utils/exception.js";

export const getContent = async (req, res, next) => {
  ContentController.getContent(req.query)
    .then((body) => res.status(ExceptionCodes.REQUEST_FULFILLED).json(body))
    .catch((err) => {
      next(err);
    });
};

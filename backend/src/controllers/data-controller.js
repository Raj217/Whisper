import { ExceptionCodes } from "../utils/exception.js";
import * as DataServices from "../services/data/index.js";

const timer = { val: null, nextScheduled: null };

export const add = (req, res, next) => {
  DataServices.add(req.body)
    .then((body) => res.status(ExceptionCodes.REQUEST_FULFILLED).json(body))
    .catch((err) => {
      next(err);
    });
};

export const chainAdd = (req, res, next) => {
  DataServices.chainAdd(req.body, req.body.loggedInUser, timer)
    .then((body) => res.status(ExceptionCodes.REQUEST_FULFILLED).json(body))
    .catch((err) => {
      next(err);
    });
};

export const stopChain = (req, res, next) => {
  DataServices.stopChain(timer)
    .then((body) => res.status(ExceptionCodes.REQUEST_FULFILLED).json(body))
    .catch((err) => {
      next(err);
    });
};

export const state = (req, res, next) => {
  DataServices.state(timer)
    .then((body) => res.status(ExceptionCodes.REQUEST_FULFILLED).json(body))
    .catch((err) => {
      next(err);
    });
};

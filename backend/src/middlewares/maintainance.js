import ApiState from "../models/api-state.js";
import { ExceptionCodes } from "../utils/exception.js";

export const maintainance = async (req, res, next) => {
  var state = await ApiState.findOne();
  var isMaintainanceActive = state.isMaintainanceActive;

  if (isMaintainanceActive) {
    return res.status(ExceptionCodes.SERVER_DOWN).send({
      message:
        "We are having a short maintainance break, please try again in a few minutes.",
    });
  } else {
    return next();
  }
};

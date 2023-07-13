import ModelBuilder from "./utils/model-builder.service.js";
import User from "../../models/user-model.js";
import Exception, { ExceptionCodes } from "../../utils/exception.js";

export const search = async (_query, loggedInUser, pagination) => {
  var { width, height, fit } = _query;
  width = parseInt(width);
  if (!width && !height) width = 500;

  const email = loggedInUser.email;
  const user = await User.findByEmail(email);
  if (!user) {
    throw new Exception("User not found", ExceptionCodes.NOT_FOUND);
  }

  var thumbnailQuality = 25,
    viewQuality = 50,
    downloadQuality = 75;

  var results = [];

  for (const img of pagination.results) {
    results.push(
      ModelBuilder.build(
        user.id,
        img,
        width,
        height,
        fit,
        thumbnailQuality,
        viewQuality,
        downloadQuality
      )
    );
  }
  pagination.results = results;
  return pagination;
};

import ModelBuilder from "./utils/model-builder.service.js";
import User from "../../models/user-model.js";
import Exception, { ExceptionCodes } from "../../utils/exception.js";

export const search = async (_query, loggedInUser, pagination) => {
  var { width, height, fit } = _query;
  width = parseInt(width);
  if (!width && !height) width = 300;

  const email = loggedInUser.email;
  const user = await User.find(email);
  if (!user) {
    throw new Exception("User not found", ExceptionCodes.NOT_FOUND);
  }

  var thumbnailQuality = 5,
    viewQuality = 30,
    downloadQuality = 65;

  var results = [];

  for (const img of pagination.results) {
    results.push(
      ModelBuilder.build(
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

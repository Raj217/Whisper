import ImageInfo from "../../models/image-info.js";

export const search = async (_query, loggedInUser, pagination) => {
  var { width, height, quality, format, fit } = _query;

  return pagination;
};

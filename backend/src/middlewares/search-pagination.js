import ImageInfo from "../models/image-info.js";
import User from "../models/user-model.js";
import Exception, { ExceptionCodes } from "../utils/exception.js";

const genSearchQuery = (query, user) => {
  var searchQuery = {};
  // NOTE: I am aware of the fact that currently it is checking the substring like
  // if outdoor is there and it also returns if door is passed, keeping it like this
  // instead of space check due to plural forms and if i enforce the before the number
  // of results might decrease thus less options to the people. Might change in future
  if (query) {
    searchQuery = {
      tags: { $regex: query, $options: "i" },
    };
  }
  if (
    user.randomImagesLastViewedCheckpoint &&
    user.randomImagesLastViewedCheckpoint !== 0
  ) {
    searchQuery["updatedAt"] = {
      $gt: new Date(user.randomImagesLastViewedCheckpoint).toISOString(),
    };
  }
  return searchQuery;
};

export const searchPagination = async (req, res, next) => {
  var { query, page, per_page } = req.query;

  if (!page) page = "1";
  if (!per_page) per_page = "10";
  page = parseInt(page);
  per_page = Math.min(parseInt(per_page), 30);

  if (page <= 0) {
    throw new Exception("Invalid Page number", ExceptionCodes.BAD_INPUT);
  }

  const startIndex = (page - 1) * per_page;

  const email = req.body.loggedInUser.email;
  const user = (await User.find(email)).data();
  var searchQuery = genSearchQuery(query, user);

  var results;
  if (query) {
    results = await ImageInfo.find(searchQuery)
      .sort("updatedAt")
      .skip(startIndex)
      .limit(per_page);
  } else {
    results = await ImageInfo.find(searchQuery)
      .sort("updatedAt")
      .limit(per_page);
  }
  const totalResults = await ImageInfo.find(searchQuery).countDocuments();

  res.pagination = {
    totalResults,
    totalPages: Math.ceil(totalResults / per_page),
    results,
  };
  next();
};

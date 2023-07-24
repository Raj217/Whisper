import ImageInfo from "../models/image-info.js";
import Exception, { ExceptionCodes } from "../utils/exception.js";

export const searchPagination = async (req, res, next) => {
  var { query, page, per_page } = req.query;

  if (!page) page = "1";
  if (!per_page) per_page = "10";
  page = parseInt(page);
  per_page = parseInt(per_page);
  if (page <= 0) {
    throw new Exception("Invalid Page number", ExceptionCodes.BAD_INPUT);
  }

  const startIndex = (page - 1) * per_page;

  var searchQuery;
  // NOTE: I am aware of the fact that currently it is checking the substring like
  // if outdoor is there and it also returns if door is passed, keeping it like this
  // instead of space check due to plural forms and if i enforce the before the number
  // of results might decrease thus less options to the people. Might change in future
  if (query) {
    searchQuery = {
      tags: { $regex: query, $options: "i" },
    };
  }
  const results = await ImageInfo.find(searchQuery)
    .skip(startIndex)
    .limit(per_page)
    .sort("updatedAt");

  const totalResults = await ImageInfo.find(searchQuery).countDocuments();

  res.pagination = {
    totalResults,
    totalPages: Math.ceil(totalResults / per_page),
    results,
  };
  next();
};

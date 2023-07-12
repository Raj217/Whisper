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
  if (query) {
    searchQuery = {
      tags: { $regex: query, $options: "i" },
    };
  }
  const results = await ImageInfo.find(searchQuery)
    .limit(per_page)
    .skip(startIndex);

  const totalResults = results.length;

  res.pagination = {
    totalResults,
    totalPages: Math.ceil(totalResults / per_page),
    results,
  };
  next();
};

import axios from "axios";
import UnsplashParser from "../parsers/unsplash-parser.service.js";
import Exception, { ExceptionCodes } from "../../../../utils/exception.js";

export const unsplashProvider = async (query, page, per_page) => {
  if (!query) {
    throw new Exception("Query is required", ExceptionCodes.BAD_INPUT);
  }
  const { UNSPLASH_API_BASE_URL, USER_AGENT } = process.env;


  const headers = {
    "User-Agent": USER_AGENT,
  };

  const url = `${UNSPLASH_API_BASE_URL}/search/photos?query=${query}&per_page=${per_page}&page=${page}&order_by=latest`;
  return await axios.get(url, headers);
};

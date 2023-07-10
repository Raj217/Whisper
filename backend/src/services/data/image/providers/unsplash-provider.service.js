import axios from "axios";
import UnsplashParser from "../parsers/unsplash-parser.service.js";
import Exception, { ExceptionCodes } from "../../../../utils/exception.js";

export const unsplashProvider = async (query, page, per_page) => {
  if (!query) {
    throw new Exception("Query is required", ExceptionCodes.BAD_INPUT);
  }
  const { UNSPLASH_API_BASE_URL } = process.env;

  // Setting default values
  if (!page) page = 1;
  if (!per_page) per_page = 10;

  const headers = {
    "User-Agent":
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.63 Safari/537.36",
  };

  const url = `${UNSPLASH_API_BASE_URL}/search/photos?query=${query}&per_page=${per_page}&page=${page}`;
  const res = await axios.get(url, headers);
  return await UnsplashParser.parse(res.data);
};

import axios from "axios";
import PexelsParser from "../parsers/pexels-parser.service.js";

export const pexelsProvider = async (query, page, per_page) => {
  if (!query) {
    throw new Exception("Query is required", ExceptionCodes.BAD_INPUT);
  }
  const { PEXELS_API_BASE_URL, USER_AGENT, PEXELS_API_SECRET_KEY } =
    process.env;

  const headers = {
    "User-Agent": USER_AGENT,
    "secret-key": PEXELS_API_SECRET_KEY,
  };

  const url = `${PEXELS_API_BASE_URL}/en-us/api/v3/search/photos?query=${query}&per_page=${per_page}&page=${page}`;

  return await axios.get(url, { headers });
};

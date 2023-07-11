import axios from "axios";
import PexelsParser from "../parsers/pexels-parser.service.js";

export const pexelsProvider = async (query, page, per_page) => {
  if (!query) {
    throw new Exception("Query is required", ExceptionCodes.BAD_INPUT);
  }
  const { PEXELS_API_BASE_URL, USER_AGENT, PEXELS_SECRET_KEY } = process.env;

  // Setting default values
  if (!page) page = 1;
  if (!per_page) per_page = 10;

  const headers = {
    "User-Agent": USER_AGENT,
    "secret-key": PEXELS_SECRET_KEY,
  };

  const url = `${PEXELS_API_BASE_URL}/en-us/api/v3/search/photos?query=${query}&per_page=${per_page}&page=${page}`;

  const res = await axios.get(url, { headers });

  if (res) return await PexelsParser.parse(res.data);
  return [];
};
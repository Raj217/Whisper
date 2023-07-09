import axios from "axios";
import UnsplashParser from "../parsers/unsplash-parser.service.js";

export const unsplashProvider = async (query, page, per_page) => {
  const { UNSPLASH_API_BASE_URL } = process.env;

  // Setting default values
  if (!page) page = 1;
  if (!per_page) per_page = 10;

  const headers = {
    "User-Agent":
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.63 Safari/537.36",

    "Accept-Language": "en-US,en;q=0.5",
    Accept:
      "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8",
    Connection: "keep-alive",
  };

  var url;
  if (query) {
    url = `${UNSPLASH_API_BASE_URL}/search/photos?query=${query}&per_page=${per_page}&page=${page}`;
  } else {
    url = `${UNSPLASH_API_BASE_URL}/photos?per_page=${per_page}&page=${page}`;
  }
  return await UnsplashParser.parse(res.data);
};

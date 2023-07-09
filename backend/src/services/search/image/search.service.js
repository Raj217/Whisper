import axios from "axios";
import { unsplashParser } from "./parsers/unsplash-parser.service.js";
import { formatUnsplashKeywords } from "./utils/data-parser.service.js";

export const search = async (query) => {
  var { keywords } = query;
  const { UNSPLASH_BASE_SEARCH_URL } = process.env;

  const res = await axios.get(
    `${UNSPLASH_BASE_SEARCH_URL}?query=${formatUnsplashKeywords(keywords)}&per_page=10&page=1`,
    { responseType: "text" }
  );
  console.log(res.status);
  console.log( `${UNSPLASH_BASE_SEARCH_URL}?query=${formatUnsplashKeywords(keywords)}&per_page=10&page=1`)

  return { res: await unsplashParser(res.data) };
};

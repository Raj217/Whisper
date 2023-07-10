import axios, { AxiosError } from "axios";
import PexelsParser from "../parsers/pexels-parser.service.js";

export const pexelsProvider = async (query, page, per_page) => {
  if (!query) {
    throw new Exception("Query is required", ExceptionCodes.BAD_INPUT);
  }
  const { PEXELS_API_BASE_URL, PEXELS_API_SECRET_KEY } = process.env;

  // Setting default values
  if (!page) page = 1;
  if (!per_page) per_page = 10;

  const headers = {
    "User-Agent":
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.63 Safari/537.36",
    "secret-key": PEXELS_API_SECRET_KEY,
    Cookie:
      "__cf_bm=oYCOX7JTJmPxMSmY.plt3FkZNBntiU5Rx7OrEAqw2Lo-1688999791-0-AVoqd/1pEnWhLUaKDF4F18NUQlGSNQe7eofaTMHwSIcLMVCIQn8oHH6rLAaZylS0z5aPJzCwDKqN9r/soeH7Q0M=",
  };

  const url = `${PEXELS_API_BASE_URL}/en-us/api/v3/search/photos?query=${query}&per_page=${per_page}&page=${page}`;

  const instance = axios.create();

  const res = await instance.get(url, { headers });
  return await PexelsParser.parse(res.data);
};

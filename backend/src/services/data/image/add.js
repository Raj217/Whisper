import APIState from "../../../models/api-state.js";
import { unsplashProvider } from "./providers/unsplash-provider.service.js";
import UnsplashParser from "./parsers/unsplash-parser.service.js";
import { pexelsProvider } from "./providers/pexels-provider.service.js";
import { ImageSource } from "../../../models/constants.js";
import Exception, { ExceptionCodes } from "../../../utils/exception.js";
import { insertImageInfo } from "./utils/insert-image-info.service.js";
import { insertTags } from "./utils/insert-tags.service.js";
import PexelsParser from "./parsers/pexels-parser.service.js";

export const add = async (_query) => {
  var { query, page, per_page: perPage, source } = _query;

  var images;
  if (!source) {
    throw new Exception("source is required", ExceptionCodes.BAD_INPUT);
  }

  // Setting default values
  if (!page) page = 1;
  if (!perPage) perPage = 10;
  
  // The actual need for mainataince is only when storing the values
  // While parsing the apis can work fine
  // But might cause delays. Let's not risk
  await APIState.findOneAndUpdate({ isMaintainanceActive: true });
  var newEntries = 0;
  var newTags;
  var didReachEnd = false;
  try {
    if (source === ImageSource.unsplash) {
      const res = await unsplashProvider(query, page, perPage);
      if (res) {
        images = await UnsplashParser.parse(res.data);
        if (res.total_pages <= page) {
          didReachEnd = true;
        }
      } else images = [];
    } else if (source === ImageSource.pexels) {
      const res = await pexelsProvider(query, page, perPage);
      if (res) {
        images = await PexelsParser.parse(res.data);
        if (res.data.pagination.total_pages <= page) {
          didReachEnd = true;
        }
      } else images = [];
    } else {
      throw new Exception("Unsupported source", ExceptionCodes.BAD_INPUT);
    }

    var { newEntries, newTagEntries } = await insertImageInfo(images);

    newTags = await insertTags(newTagEntries, source);
  } finally {
    await APIState.findOneAndUpdate({ isMaintainanceActive: false });
  }
  return { newEntries, newTags, didReachEnd };
};

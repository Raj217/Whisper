import ImageInfo from "../../../models/image_info_model.js";
import { unsplashProvider } from "./providers/unsplash-provider.service.js";
import { pexelsProvider } from "./providers/pexels-provider.service.js";
import { ImageSource } from "../../../models/constants.js";
import Exception, { ExceptionCodes } from "../../../utils/exception.js";

export const add = async (_query) => {
  var { query, page, per_page, source } = _query;

  var images;
  if (!source) {
    throw new Exception("source is required", ExceptionCodes.BAD_INPUT);
  }
  if (source === ImageSource.unsplash) {
    images = await unsplashProvider(query, page, per_page);
  } else if (source === ImageSource.pexels) {
    images = await pexelsProvider(query, page, per_page);
  } else {
    throw new Exception("Unsupported source", ExceptionCodes.BAD_INPUT);
  }
  var newEntries = 0;
  for (var img of images) {
    try {
      await ImageInfo.create(img);
      newEntries++;
    } catch (e) {
      // Duplicates error
    }
  }
  return { newEntries };
};

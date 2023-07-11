import APIState from "../../../models/api-state.js";
import { unsplashProvider } from "./providers/unsplash-provider.service.js";
import { pexelsProvider } from "./providers/pexels-provider.service.js";
import { ImageSource } from "../../../models/constants.js";
import Exception, { ExceptionCodes } from "../../../utils/exception.js";
import { insertImageInfo } from "./utils/insert-image-info.service.js";
import { insertTags } from "./utils/insert-tags.service.js";

export const add = async (_query) => {
  var { query, page, per_page, source } = _query;

  var images;
  if (!source) {
    throw new Exception("source is required", ExceptionCodes.BAD_INPUT);
  }

  // The actual need for mainataince is only when storing the values
  // While parsing the apis can work fine
  // But might cause delays. Let's not risk
  await APIState.findOneAndUpdate({ isMaintainanceActive: true });
  var newEntries = 0;
  var newTags;
  try {
    if (source === ImageSource.unsplash) {
      images = await unsplashProvider(query, page, per_page);
    } else if (source === ImageSource.pexels) {
      images = await pexelsProvider(query, page, per_page);
    } else {
      throw new Exception("Unsupported source", ExceptionCodes.BAD_INPUT);
    }

    var { newEntries, newTagEntries } = await insertImageInfo(images);

    newTags = await insertTags(newTagEntries, source);
  } finally {
    await APIState.findOneAndUpdate({ isMaintainanceActive: false });
  }
  return { newEntries, newTags };
};

import ImageInfo from "../../../models/image_info.js";
import Tag from "../../../models/tag.js";
import APIState from "../../../models/api_state.js";
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
  await APIState.findOneAndUpdate({ isMaintainanceActive: true });
  var newEntries = 0;
  var newTagEntries = new Map();
  try {
    if (source === ImageSource.unsplash) {
      images = await unsplashProvider(query, page, per_page);
    } else if (source === ImageSource.pexels) {
      images = await pexelsProvider(query, page, per_page);
    } else {
      throw new Exception("Unsupported source", ExceptionCodes.BAD_INPUT);
    }
    for (var img of images) {
      try {
        await ImageInfo.create(img);
        for (var tag of img.tags) {
          if (!newTagEntries.has(tag)) {
            newTagEntries.set(tag, 0);
          }
          newTagEntries.set(tag, newTagEntries.get(tag) + 1);
        }
        newEntries++;
      } catch (e) {
        // Duplicates error
      }
    }

    var newTags = [];
    for (var [tag, count] of newTagEntries) {
      newTags.push(tag);
      var tagEntry = await Tag.findOne({ tag });
      if (!tagEntry) {
        var data = { tag };
        if (source === ImageSource.unsplash) {
          data.unsplashScraped = count;
        } else {
          data.pexelsScraped = count;
        }
        await Tag.create(data);
      } else {
        var data = {};
        if (source === ImageSource.unsplash) {
          data.unsplashScraped = tagEntry.unsplashScraped + count;
        } else {
          data.pexelsScraped = tagEntry.pexelsScraped + count;
        }
        await Tag.findByIdAndUpdate(tagEntry.id, data);
      }
    }
  } finally {
    await APIState.findOneAndUpdate({ isMaintainanceActive: false });
  }
  return { newEntries, newTags };
};

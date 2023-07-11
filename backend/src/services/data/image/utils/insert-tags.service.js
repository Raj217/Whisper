import Tag from "../../../../models/tag.js";
import { ImageSource } from "../../../../models/constants.js";

export const insertTags = async (newTagEntries, source) => {
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
  return newTags;
};

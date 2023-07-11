import ImageInfo from "../../../../models/image-info.js";

export const insertImageInfo = async (images) => {
  var newTagEntries = new Map();
  var newEntries = 0;

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
  return { newEntries, newTagEntries };
};

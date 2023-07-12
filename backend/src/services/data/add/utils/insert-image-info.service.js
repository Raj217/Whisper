import ImageInfo from "../../../../models/image-info.js";

export const insertImageInfo = async (images) => {
  var newTagEntries = new Map();
  var newEntriesCount = 0;

  for (var img of images) {
    try {
      const info = await ImageInfo.create(img);
      for (var tag of img.tags) {
        if (!newTagEntries.has(tag)) {
          newTagEntries.set(tag, new Set());
        }
        newTagEntries.get(tag).add(info.id);
      }
      newEntriesCount++;
    } catch (e) {
      // Duplicates error
    }
  }
  return { newEntriesCount, newTagEntries };
};

import Tag from "../../../../models/tag.js";

export const insertTags = async (newTagEntries) => {
  var newTags = [];
  for (var [tag, ids] of newTagEntries) {
    newTags.push(tag);
    ids = Array.from(ids);
    var tagEntry = await Tag.findOne({ tag });
    if (!tagEntry) {
      var data = { tag, ids };
      await Tag.create(data);
    } else {
      var data = {
        ids: [...tagEntry.ids, ...ids],
      };
      await Tag.findByIdAndUpdate(tagEntry.id, data);
    }
  }
  return newTags;
};

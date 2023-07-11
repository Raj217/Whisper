import Tag from "../../../models/tag.js";
import APIState from "../../../models/api-state.js";

export const didFinishScrapingTag = async (tag) => {
  const tagData = await Tag.find({ tag });
  if (
    !tagData ||
    tagData.didFinishScrapingUnsplash === false ||
    tagData.didFinishScrapingPexels === false
  ) {
    return false;
  }
  return true;
};

/**
 * If the tag state is saved as scraped it changes the state to make it scrapable
 */
export const initTagScraping = async (tag) => {
  const tagData = await Tag.find({ tag });
  if (!tagData) {
    if (tagData.didFinishScrapingUnsplash || tagData.didFinishScrapingPexels) {
      tagData.didFinishScrapingUnsplash = false;
      tagData.didFinishScrapingPexels = false;
      await Tag.findByIdAndUpdate(tagData.id, tagData);
    }
  }
};

/**
 * It makes the currentlyScraping state ready for the next scrape
 */
export const initScraping = async () => {
  var state = await APIState.findOne();

  const tags = new Set(state.tagsToScrape);
  tags.add(query);

  if (!state.currentlyScraping) {
    for (const tag of tags) {
      if (!(await didFinishScrapingTag(tag))) {
        state.currentlyScraping = tag;
        state.unsplashScraped = 0;
        state.pexelsScraped = 0;
        break;
      } else {
        tags.delete(tag);
      }
    }
  }

  await APIState.findByIdAndUpdate(state.id, state);
};

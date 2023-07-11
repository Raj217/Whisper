import Tag from "../../../models/tag.js";
import APIState from "../../../models/api-state.js";
import { ImageSource } from "../../../models/constants.js";
import { add } from "../image/add.js";

export const didFinishScrapingTag = async (tag) => {
  const tagData = await Tag.findOne({ tag });
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
  if (tagData) {
    if (tagData.didFinishScrapingUnsplash || tagData.didFinishScrapingPexels) {
      tagData.didFinishScrapingUnsplash = false;
      tagData.didFinishScrapingPexels = false;
      await Tag.findByIdAndUpdate(tagData.id, tagData);
    }
  } else {
    await Tag.create({ tag });
  }
};

/**
 * It makes the currentlyScraping state ready for the next scrape
 */
export const initScraping = async (query) => {
  var state = await APIState.findOne();

  const tags = new Set(state.tagsToScrape);
  tags.add(query);

  if (!state.currentlyScraping) {
    for (const tag of tags) {
      if (!(await didFinishScrapingTag(tag))) {
        state.currentlyScraping = tag;
        state.unsplashPageNo = 1;
        state.pexelsPageNo = 1;
        break;
      } else {
        tags.delete(tag);
      }
    }
  }

  await APIState.findByIdAndUpdate(state.id, state);
  if (state.currentlyScraping) return true;
  return false;
};

const scrapeTag = async (tags, query, page, perPage, source, chainTags) => {
  var { newTags, didReachEnd } = await add({
    query: query,
    page: page,
    per_page: perPage,
    source: source,
  });

  if (chainTags === true) {
    for (const tag of newTags) {
      await initTagScraping(tag);
      tags.vals.add(tag);
    }
  }
  return didReachEnd;
};
export const scrape = async (chainTags) => {
  const { PER_PAGE } = process.env;
  var state = await APIState.findOne();

  var tags = { vals: new Set() };
  for (var tag in state.tagsToScrape) {
    tags.vals.add(tag);
  }

  var currentlyScraping = state.currentlyScraping;
  var unsplashPageNo = state.unsplashPageNo;
  var pexelsPageNo = state.pexelsPageNo;

  if (
    await scrapeTag(
      tags,
      currentlyScraping,
      unsplashPageNo,
      PER_PAGE,
      ImageSource.unsplash,
      chainTags
    )
  ) {
    unsplashPageNo = 0;
  } else {
    unsplashPageNo++;
  }

  if (
    await scrapeTag(
      tags,
      currentlyScraping,
      pexelsPageNo,
      PER_PAGE,
      ImageSource.pexels,
      chainTags
    )
  ) {
    pexelsPageNo = 0;
  } else {
    pexelsPageNo++;
  }

  if (pexelsPageNo === 0 || unsplashPageNo === 0) {
    var tagData = await Tag.findOne({ tag: currentlyScraping });
    await Tag.findByIdAndUpdate(tagData.id, {
      didFinishScrapingPexels: pexelsPageNo === 0,
      didFinishScrapingUnsplash: unsplashPageNo === 0,
    });
  }
  if (pexelsPageNo === 0 && unsplashPageNo === 0) {
    currentlyScraping = null;
  }

  const tagsToScrape = Array.from(tags.vals);
  await APIState.findByIdAndUpdate(state.id, {
    currentlyScraping,
    pexelsPageNo,
    unsplashPageNo,
    tagsToScrape,
  });
};

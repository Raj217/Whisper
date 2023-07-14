import Tag from "../../../models/tag.js";
import APIState from "../../../models/api-state.js";
import { ImageSource, ImageSourceArr } from "../../../models/constants.js";
import { add } from "../add/add.js";

export const didFinishScrapingTag = async (tag) => {
  const tagData = await Tag.findOne({ tag });
  if (
    tagData &&
    tagData.didFinishScrapingUnsplash === true &&
    tagData.didFinishScrapingPexels === true
  ) {
    return true;
  }
  return false;
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
 * @return {Promise<Boolean>} true if there is any tag found for scraping
 */
export const initScraping = async (query) => {
  var state = await APIState.findOne();

  const tags = new Set(state.tagsToScrape);
  tags.add(query);

  if (!state.currentlyScraping) {
    for (const tag of tags) {
      if (!(await didFinishScrapingTag(tag))) {
        state.currentlyScraping = tag;
        state.unsplashPage = 1;
        state.pexelsPage = 1;
        break;
      } else {
        tags.delete(tag);
      }
    }
  }

  state.tagsToScrape = Array.from(tags);
  await APIState.findByIdAndUpdate(state.id, state);

  if (state.currentlyScraping && state.currentlyScraping != null) return true;
  return false;
};

/**
 * Scrape and update new tags
 * @returns {Promise<Boolean>} true if scraping for the tag is completed
 */
const scrapeAndUpdateTags = async (
  tags,
  query,
  page,
  perPage,
  source,
  chainNewTags,
  partialScrape
) => {
  if (page !== 0) {
    var { newEntriesCount, newTags, didReachEnd } = await add({
      query: query,
      page: page,
      per_page: perPage,
      source: source,
    });

    if (chainNewTags === true) {
      for (const tag of newTags) {
        await initTagScraping(tag);
        tags.vals.add(tag);
      }
    }

    if (didReachEnd) return true;
    else if (partialScrape === true) return newEntriesCount === 0;

    return false;
  } else {
    return true;
  }
};

/**
 * updates the tags if the scraping is completed
 * @return {Promise<Boolean>} true if the scraping is completed for the given tag
 */
const updateTagsScrapingState = async (page, currentlyScraping) => {
  var isScrapingCompleted = true;

  for (var source of ImageSourceArr) {
    if (page[source] === 0) {
      var tagData = await Tag.findOne({ tag: currentlyScraping });
      await Tag.findByIdAndUpdate(tagData.id, {
        didFinishScrapingUnsplash: page.get(ImageSource.unsplash) === 0,
        didFinishScrapingPexels: page.get(ImageSource.pexels) === 0,
      });
    } else {
      isScrapingCompleted = false;
    }
  }
  return isScrapingCompleted;
};

export const scrape = async (chainNewTags, partialScrape) => {
  const { PER_PAGE } = process.env;
  var state = await APIState.findOne();

  var tags = { vals: new Set(state.tagsToScrape) };
  var currentlyScraping = state.currentlyScraping;

  var page = new Map();
  page.set(ImageSource.unsplash, state.unsplashPage);
  page.set(ImageSource.pexels, state.pexelsPage);

  for (const source of ImageSourceArr) {
    if (
      await scrapeAndUpdateTags(
        tags,
        currentlyScraping,
        page.get(source),
        PER_PAGE,
        source,
        chainNewTags,
        partialScrape
      )
    ) {
      page.set(source, 0);
    } else {
      page.set(source, page.get(source) + 1);
    }
    console.log(`${source} parsed`);
  }

  if (await updateTagsScrapingState(page, currentlyScraping)) {
    currentlyScraping = null;
  }

  const tagsToScrape = Array.from(tags.vals);
  await APIState.findByIdAndUpdate(state.id, {
    currentlyScraping,
    unsplashPage: page.get(ImageSource.unsplash),
    pexelsPage: page.get(ImageSource.pexels),
    tagsToScrape,
  });
};

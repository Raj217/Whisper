import APIState from "../../../models/api-state.js";

export const state = async (timer) => {
  var info = {};
  if (timer.val === null) {
    info.scraping = false;
  } else {
    info.scraping = true;
    info.nextScheduled = timer.nextScheduled;
  }

  const state = await APIState.findOne();
  
  info.isMaintainanceActive = state.isMaintainanceActive;
  info.currentlyScraping = state.currentlyScraping ?? null;
  info.tagsToScrape = state.tagsToScrape;
  info.unsplashScraped = info.unsplashScraped ?? 0;
  info.pexelsScraped = info.pexelsScraped ?? 0;

  return { info };
};

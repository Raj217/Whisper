import APIState from "../../../models/api-state.js";
import { toIST } from "../../../utils/time.service.js";

export const state = async (timer) => {
  var info = {};
  if (timer.val === null) {
    info.scraping = false;
  } else {
    info.scraping = true;
    info.nextScheduled = Date(timer.nextScheduled);
  }

  const state = await APIState.findOne();

  info.isMaintainanceActive = state.isMaintainanceActive;
  info.currentlyScraping = state.currentlyScraping ?? null;
  info.unsplashPage = state.unsplashPage;
  info.pexelsPage = state.pexelsPage;
  info.tagsToScrape = state.tagsToScrape;

  return { info };
};

import { initScraping, initTagScraping, scrape } from "./utils.service.js";
import { generateRandomTime } from "../../../utils/app-utils.service.js";
import APIState from "../../../models/api-state.js";

export const chainAdd = async (_query, timer) => {
  // If chainNewTags is true, the tags which will be found during parsing the current
  // will be chained and images realted to that topic will also be scraped
  // i.e. didFinishScrapingUnsplash and didFinishScrapingPexels of the chained tag along with the query tag will be set to false
  //
  // In partial_scrape if no new entries then the scraping is halted
  var { query, chainNewTags, partialScrape } = _query;

  partialScrape ??= true;
  chainNewTags ??= false;

  if (timer.val !== null) {
    clearTimeout(timer.val);
    timer.val = null;
  }
  await APIState.findOneAndUpdate({ isMaintainanceActive: true });
  try {
    if (query) await initTagScraping(query);
    const doesContainAnyTagToScrape = await initScraping(query);

    if (doesContainAnyTagToScrape) {
      await scrape(chainNewTags, partialScrape);

      const interval = generateRandomTime(10, 13);

      timer.val = setTimeout(() => {
        chainAdd({ chainNewTags }, timer);
      }, interval);

      const now = Date.now();
      const nextScheduled = new Date(now + interval);
      timer.nextScheduled = nextScheduled;

      console.log(
        `Now: ${new Date(now)}\nNext Scheduled: ${toIST(newScheduled)}`
      );
      return { message: "Scraping Started" };
    } else {
      return { message: "No Tag to scrape" };
    }
  } finally {
    await APIState.findOneAndUpdate({ isMaintainanceActive: false });
    return;
  }
};

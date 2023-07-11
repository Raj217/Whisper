import { initScraping, initTagScraping } from "./utils.service.js";
import { getRandomTime as generateRandomTime } from "../../../utils/app-utils.service.js";

export const chainAdd = async (_query, timer) => {
  // If chainTags is true, the tags which will be found during parsing the current
  // will be chained and images realted to that topic will also be scraped
  // i.e. didFinishScrapingUnsplash and didFinishScrapingPexels of the chained tag along with the query tag will be set to false
  var { query, chainTags } = _query;

  if (!query) await initTagScraping(query);
  await initScraping();

  if (timer.val !== null) {
    clearTimeout(timer.val);
    timer.val = null;
  }

  const interval = generateRandomTime(30, 45);
  timer.val = setTimeout(() => {
    chainAdd({ chainTags }, timer);
  }, interval);

  const now = Date.now();
  const nextScheduled = new Date(now + interval);
  timer.nextScheduled = nextScheduled;
  
  console.log(`Now: ${new Date(now)}\nNext Scheduled: ${nextScheduled}`);
  return { message: "Scraping Started" };
};

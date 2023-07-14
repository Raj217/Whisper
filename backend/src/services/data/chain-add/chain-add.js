import { initScraping, initTagScraping, scrape } from "./utils.service.js";
import { generateRandomTime } from "../../../utils/app-utils.service.js";
import axios from "axios";
import generateToken from "../../auth/utils/generate-token.js";
import APIState from "../../../models/api-state.js";

export const chainAdd = async (body, loggedInUser, timer) => {
  // If chainNewTags is true, the tags which will be found during parsing the current
  // will be chained and images realted to that topic will also be scraped
  // i.e. didFinishScrapingUnsplash and didFinishScrapingPexels of the chained tag along with the query tag will be set to false
  //
  // In partial_scrape if no new entries then the scraping is halted
  var { query, chainNewTags, partialScrape } = body;

  partialScrape ??= true;
  chainNewTags ??= false;
  
  try {
    if (timer.val !== null) {
      clearTimeout(timer.val);
      timer.val = null;
    }
    if (query) await initTagScraping(query);
    const doesContainAnyTagToScrape = await initScraping(query);

    if (doesContainAnyTagToScrape) {
      await scrape(chainNewTags, partialScrape);

      const interval = generateRandomTime(10, 13);

      const now = Date.now();
      const nextScheduled = new Date(now + interval);
      console.log(`Now: ${new Date(now)}\nNext Scheduled: ${nextScheduled}`);

      timer.val = setTimeout(() => {
        axios.post(
          `http://localhost:${process.env.PORT_NO}/api/v0/data/chain-add`,
          {
            chainNewTags,
            partialScrape,
          },
          {
            headers: {
              Authorization: generateToken(
                loggedInUser.email,
                loggedInUser.emailVerified
              ),
            },
          }
        );
      }, interval);
      timer.nextScheduled = nextScheduled;

      return { message: "Scraping Started" };
    } else {
      return { message: "No Tag to scrape" };
    }
  } catch (err) {
    console.error(err);
  } finally {
    await APIState.findOneAndUpdate({ isMaintainanceActive: false });
  }
};

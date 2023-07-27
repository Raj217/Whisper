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
  var { query, chainNewTags, partialScrape, nextCallMinGap, nextCallMaxGap } =
    body;

  partialScrape ??= true;
  chainNewTags ??= false;
  nextCallMinGap ??= 10;
  nextCallMaxGap ??= 14;

  try {
    if (timer.val !== null) {
      clearTimeout(timer.val);
      timer.val = null;
    }
    if (query) await initTagScraping(query);
    const doesContainAnyTagToScrape = await initScraping(query);

    if (doesContainAnyTagToScrape) {
      await scrape(chainNewTags, partialScrape);

      const interval = generateRandomTime(nextCallMinGap, nextCallMaxGap);

      const now = Date.now();
      const nextScheduled = new Date(now + interval);
      console.log(`Now: ${new Date(now)}\nNext Scheduled: ${nextScheduled}`);

      const { USER_AGENT } = process.env;

      timer.val = setTimeout(async () => {
        // chainAdd(
        //   {
        //     chainNewTags,
        //     partialScrape,
        //     nextCallMinGap,
        //     nextCallMaxGap,
        //   },
        //   loggedInUser,
        //   timer
        // );
        axios.post(
          `${process.env.BACKEND_BASE_URL}/api/v0/data/chain-add`,
          {
            chainNewTags,
            partialScrape,
            nextCallMinGap,
            nextCallMaxGap,
          },
          {
            headers: {
              Authorization: generateToken(
                loggedInUser.email,
                loggedInUser.emailVerified
              ),

              "User-Agent": USER_AGENT,
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

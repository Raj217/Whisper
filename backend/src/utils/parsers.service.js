import { load } from "cheerio";
import axios from "axios";

class Parsers {
  static parseFilteredUnsplashSrcs(data, hosts) {
    const { UNSPLASH_CONTENT_CLASS_NAME } = process.env;
    const $ = load(data);

    const items = $(`.${UNSPLASH_CONTENT_CLASS_NAME.split(" ").join(".")}`);
    var srcs = [];
    for (var item of items) {
      const imageUrl = $(item).find("img").attr("src");
      const host = new URL(imageUrl).host;
      const contentPathName = $(item).attr("href");
      if (hosts.has(host)) {
        srcs.push({
          imageUrl,
          contentPathName,
        });
      }
    }
    return srcs;
  }
  static parseUnsplashIDs(srcs) {
    const ids = [];
    const contentPathNames = [];
    for (const src of srcs) {
      const pathname = new URL(src.imageUrl).pathname;
      // index start from 7 for /photo-
      ids.push(pathname.slice(7));
      contentPathNames.push(src.contentPathName);
    }
    return { ids, contentPathNames };
  }
  static async parseUnsplashOwnerAndTags(contentPathName) {
    const {
      UNSPLASH_PUBLISHER_CLASS_NAME,
      UNSPLASH_BASE_URL,
      UNSPLASH_TAGS_CLASS_NAME,
    } = process.env;
    const res = await axios.get(`${UNSPLASH_BASE_URL}${contentPathName}`, {
      responseType: "text",
    });
    const $ = load(res.data);

    const publisher = $(
      `.${UNSPLASH_PUBLISHER_CLASS_NAME.split(" ").join(".")}`
    );
    const publisherName = $(publisher).text();
    const publisherUrl = `${UNSPLASH_BASE_URL}${$(publisher).attr("href")}`;
    const tags = [];
    for (const tag of $(
      `.${UNSPLASH_TAGS_CLASS_NAME.split(" ").join(".")}`
    ).find("a")) {
      tags.push($(tag).text());
    }

    return { publisherName, publisherUrl, tags };
  }
  static filterSrcsWithHosts(srcs, hosts) {
    var filtered = [];
    for (const src of srcs) {
      const host = new URL(src).host;
      if (hosts.has(host)) {
        filtered.push(src);
      }
    }
    return filtered;
  }
}

export default Parsers;

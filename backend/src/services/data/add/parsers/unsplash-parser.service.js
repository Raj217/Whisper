import axios from "axios";
import { ImageSource } from "../../../../models/constants.js";

class UnsplashParser {
  static async _fetchTags(contentID) {
    const { UNSPLASH_API_BASE_URL } = process.env;
    const res = await axios.get(`${UNSPLASH_API_BASE_URL}/photos/${contentID}`);

    const tags = new Set();
    for (const tag of res.data.tags) {
      var {title} = tag;
      tags.add(title);
    }
    return Array.from(tags);
  }

  static _parseImageID(url) {
    const pathName = new URL(url).pathname;
    // +6 for photo-
    return pathName.slice(pathName.indexOf("photo-") + 6);
  }

  static async parse(data) {
    const images = [];
    for (var item of data.results) {
      if (item.premium === false) {
        const {
          id: contentID,
          urls: { raw: url },
          color,
          user: {
            name: publisherName,
            links: { html: publisherUrl },
          },
        } = item;
        images.push({
          imageSourceID: UnsplashParser._parseImageID(url),
          publisherName,
          publisherUrl,
          tags: await this._fetchTags(contentID),
          source: ImageSource.unsplash,
          color,
          views: 0,
          downloads: 0,
        });
      }
    }
    return images;
  }
}

export default UnsplashParser;

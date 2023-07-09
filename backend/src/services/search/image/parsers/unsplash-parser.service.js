import axios from "axios";
import { ImageSource } from "../../../../models/constants.js";

class UnsplashParser {
  async _fetchTags(contentID) {
    const { UNSPLASH_API_BASE_URL } = process.env;
    const res = await axios.get(`${UNSPLASH_API_BASE_URL}/photos/${contentID}`);

    return res.data.tags.map(({ title }) => title);
  }

  _parseImageID(url) {
    const pathName = new URL(url).pathname;
    // +6 for photo-
    return pathName.slice(pathName.indexOf("photo-") + 6);
  }

  async parse(data) {
    const images = [];
    for (var item of data) {
      if (item.premium === false) {
        const {
          id: contentID,
          urls: { raw: url },
          user: {
            name: publisherName,
            links: { portfolio: publisherUrl },
          },
        } = item;
        images.push({
          id: this._parseImageID(url),
          publisherName,
          publisherUrl,
        //   tags: await this._fetchTags(contentID),
          source: ImageSource.unsplash,
          views: 0,
          downloads: 0,
        });
      }
    }
    return images;
  }
}

export default UnsplashParser;

import axios from "axios";
import { ImageSource } from "../../../../models/constants.js";

class PexelsParser {
  static async parse(data) {
    const {PEXELS_API_BASE_URL} = process.env;
    const images = [];
    for (var item of data.data) {
        const {
          attributes: {
            id,
            user: {
                first_name: publisherFirstName,
                last_name: publisherLastName,
                username: publisherUserName
            },
            tags,

          },
        } = item;
        images.push({
          id,
          publisherName: `${publisherFirstName} ${publisherLastName}`,
          publisherUrl: `${PEXELS_API_BASE_URL}/@${publisherUserName}`,
          tags: tags,
          source: ImageSource.pexels,
          views: 0,
          downloads: 0,
        });
    }
    return images;
  }
}

export default PexelsParser;

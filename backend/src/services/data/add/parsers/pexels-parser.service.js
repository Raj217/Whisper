import { ImageSource } from "../../../../models/constants.js";

class PexelsParser {
  static _convertToHex(val) {
    return parseInt(val).toString(16);
  }
  static _rgbToHex(rgb) {
    var hex = "#";
    for (var val of rgb) {
      hex += PexelsParser._convertToHex(val);
    }
    return hex;
  }

  static _parseFileName(url) {
    const pathName = new URL(url).pathname;
    const fileName = pathName.split("/").at(-1);
    return fileName;
  }
  static async parse(data) {
    const { PEXELS_API_BASE_URL } = process.env;
    const images = [];
    for (var item of data.data) {
      var {
        attributes: {
          id,
          user: {
            first_name: publisherFirstName,
            last_name: publisherLastName,
            username: publisherUserName,
          },
          image: { download_link: url },
          main_color: mainColor,
          tags,
        },
      } = item;
      tags = Array.from(new Set(tags));
      images.push({
        imageSourceID: id,
        publisherName: `${publisherFirstName} ${publisherLastName}`,
        publisherUrl: `${PEXELS_API_BASE_URL}/@${publisherUserName}`,
        tags: tags,
        color: PexelsParser._rgbToHex(mainColor),
        source: ImageSource.pexels,
        extra: {
          fileName: PexelsParser._parseFileName(url),
        },
      });
    }
    return images;
  }
}

export default PexelsParser;

import { ImageSource } from "../../models/constants.js";
import URLGenerator from "./utils/url-generator.service.js";
import ModelBuilder from "./utils/model-builder.service.js";

export const search = async (_query, loggedInUser, pagination) => {
  var { width, height, format, fit } = _query;
  width = parseInt(width);
  height = parseInt(height);
  if (!width && !height) width = 500;

  var lowResQuality = 25,
    midResQuality = 50,
    highResQuality = 75;
  const UnsplashURLGenerator = new URLGenerator(
    ImageSource.unsplash,
    width,
    height,
    format,
    fit,
    lowResQuality,
    midResQuality,
    highResQuality
  );
  const PexelsURLGenerator = new URLGenerator(
    ImageSource.pexels,
    width,
    height,
    format,
    fit,
    lowResQuality,
    midResQuality,
    highResQuality
  );

  var results = [];

  for (const img of pagination.results) {
    var lowRes, midRes, highRes;
    if (img.source === ImageSource.unsplash) {
      var { lowRes, midRes, highRes } = UnsplashURLGenerator.generate3Formats(
        img.imageSourceID
      );
    } else if (img.source === ImageSource.pexels) {
      var { lowRes, midRes, highRes } = PexelsURLGenerator.generate3Formats(
        img.imageSourceID,
        img.extra.defaultFileFormat
      );
    }
    results.push(ModelBuilder.build(img, lowRes, midRes, highRes));
  }
  pagination.results = results;
  return pagination;
};

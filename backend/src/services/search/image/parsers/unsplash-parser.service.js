import Parsers from "../../../../utils/parsers.service.js";

export const unsplashParser = async (data) => {
  const hosts = new Set(["images.unsplash.com"]);
  const imageAndContentSrcs = Parsers.parseFilteredUnsplashSrcs(data, hosts);

  const { ids, contentPathNames } =
    Parsers.parseUnsplashIDs(imageAndContentSrcs);
  const publisherNames = [],
    publisherUrls = [],
    tags = [];
  for (const pathName of contentPathNames) {
    const data = await Parsers.parseUnsplashOwnerAndTags(pathName);
    publisherNames.push(data.publisherName);
    publisherUrls.push(data.publisherUrl);
    tags.push(data.tags);
  }
  
  return { ids, publisherNames, publisherUrls, tags };
};

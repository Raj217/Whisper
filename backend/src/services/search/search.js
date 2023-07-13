import ModelBuilder from "./utils/model-builder.service.js";

export const search = async (_query,  pagination) => {
  var { width, height, fit } = _query;
  width = parseInt(width);
  height = parseInt(height);
  if (!width && !height) width = 500;

  var thumbnailQuality = 25,
    viewQuality = 50,
    downloadQuality = 75;

  var results = [];

  for (const img of pagination.results) {
    results.push(
      ModelBuilder.build(
        img,
        width,
        height,
        fit,
        thumbnailQuality,
        viewQuality,
        downloadQuality
      )
    );
  }
  pagination.results = results;
  return pagination;
};

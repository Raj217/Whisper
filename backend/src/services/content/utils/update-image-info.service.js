import { ImagePurpose } from "../../../models/constants.js";
import ImageInfo from "../../../models/image-info.js";

export const updateImageInfo = async (purpose, imageData) => {
  var views = imageData.views;
  var downloads = imageData.downloads;

  switch (purpose) {
    case ImagePurpose.thumbnail:
      views += 1 / 3;
      break;
    case ImagePurpose.view:
      views++;
      break;
    case ImagePurpose.download:
      downloads++;
      break;
  }

  await ImageInfo.findByIdAndUpdate(imageData.id, {
    views,
    downloads,
  });
};

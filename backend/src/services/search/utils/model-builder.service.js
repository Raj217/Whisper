import Cipher from "../../../utils/cipher-utils.service.js";
import URLGenerator from "../../../utils/url-generator.service.js";
import { ImagePurpose } from "../../../models/constants.js";

class ModelBuilder {
  static wrapData(id, purpose, src) {
    return [id, purpose, src];
  }
  static buildURL(id, purpose, src, quality) {
    const { BACKEND_BASE_URL } = process.env;
    const data = ModelBuilder.wrapData(id, purpose, src);
    return `${BACKEND_BASE_URL}/api/v0/content?id=${Cipher.encrypt(
      data
    )}&${this.urlGenerator.generateQueries(quality)}`;
  }
  static build(
    imageData,
    w,
    h,
    fit,
    thumbnailQuality,
    viewQuality,
    downloadQuality
  ) {
    this.urlGenerator = new URLGenerator(imageData.source, w, h, fit);
    return {
      publisherName: imageData.publisherName,
      publisherURL: imageData.publisherUrl,
      tags: imageData.tags,
      color: imageData.color,
      images: {
        thumbnail: ModelBuilder.buildURL(
          imageData.id,
          ImagePurpose.thumbnail,
          imageData.source,
          thumbnailQuality
        ),
        view: ModelBuilder.buildURL(
          imageData.id,
          ImagePurpose.view,
          imageData.source,
          viewQuality
        ),
        download: ModelBuilder.buildURL(
          imageData.id,
          ImagePurpose.download,
          imageData.source,
          downloadQuality
        ),
      },
    };
  }
}

export default ModelBuilder;

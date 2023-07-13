import Cipher from "../../../utils/cipher-utils.service.js";
import URLGenerator from "../../../utils/url-generator.service.js";

class ModelBuilder {
  static wrapData(id, download, src) {
    return [id, download, src];
  }
  static buildURL(id, download, src, quality) {
    const { BACKEND_BASE_URL } = process.env;
    const data = ModelBuilder.wrapData(id, download, src);
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
          false,
          imageData.source,
          thumbnailQuality
        ),
        view: ModelBuilder.buildURL(
          imageData.id,
          false,
          imageData.source,
          viewQuality
        ),
        download: ModelBuilder.buildURL(
          imageData.id,
          true,
          imageData.source,
          downloadQuality
        ),
      },
    };
  }
}

export default ModelBuilder;

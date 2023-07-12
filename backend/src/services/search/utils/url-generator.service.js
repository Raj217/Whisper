import { ImageSource } from "../../../models/constants.js";

class URLGenerator {
  constructor(
    source,
    width,
    height,
    format,
    fit,
    lowResQuality,
    midResQuality,
    highResQuality
  ) {
    this.source = source;
    this.width = width;
    this.height = height;
    this.format = format;
    this.fit = fit;
    this.lowResQuality = lowResQuality ?? 1;
    this.midResQuality = midResQuality ?? 25;
    this.highResQuality = highResQuality ?? 75;
  }
  _addQueryToURL(prop, val) {
    if (!this.didAddAnyQuery) {
      this.url += `?${prop}=${val}`;
      this.didAddAnyQuery = true;
    } else {
      this.url += `&${prop}=${val}`;
    }
  }

  _buildBaseURL(id, defaultFileFormat) {
    const { UNSPLASH_IMAGE_API_BASE_URL, PEXELS_IMAGE_API_BASE_URL } =
      process.env;
    this.didAddAnyQuery = false;
    if (this.source === ImageSource.unsplash) {
      this.url = `${UNSPLASH_IMAGE_API_BASE_URL}${id}`;
    } else if (this.source === ImageSource.pexels) {
      this.url = `${PEXELS_IMAGE_API_BASE_URL}${id}/pexels-photo-${id}.${defaultFileFormat}`;
    }
  }

  /**
   * Generates image url
   * @param {*} id : Image source Id
   * @param {*} defaultFileFormat the default file format (required for pexels API)
   */
  _generate(id, quality, defaultFileFormat) {
    this._buildBaseURL(id, defaultFileFormat);
    if (this.width) this._addQueryToURL("w", this.width);
    if (this.height) this._addQueryToURL("h", this.height);
    if (quality) this._addQueryToURL("q", quality);
    if (this.format) this._addQueryToURL("fm", "jpg");
    this._addQueryToURL("auto", "format");
    if (this.source === ImageSource.unsplash) {
      this._addQueryToURL("crop", "entropy");
      this._addQueryToURL("fit", this.fit ?? "crop");
    } else if (this.source === ImageSource.pexels) {
      this._addQueryToURL("fit", this.fit ?? "scale");
      this._addQueryToURL("cs", "tinysrgb");
    }
    return this.url;
  }
  generate3Formats(id, defaultFileFormat) {
    const lowRes = this._generate(id, this.lowResQuality, defaultFileFormat);
    const midRes = this._generate(id, this.midResQuality, defaultFileFormat);
    const highRes = this._generate(id, this.highResQuality, defaultFileFormat);
    return { lowRes, midRes, highRes };
  }
}

export default URLGenerator;

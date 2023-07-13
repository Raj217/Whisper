import { ImageSource } from "../models/constants.js";

class URLGenerator {
  constructor(source, width, height, fit) {
    this.source = source;
    this.width = width;
    this.height = height;
    this.fit = fit;
  }
  _addQuery(prop, val) {
    if (!this.queries || this.queries.length === 0) {
      this.queries = `${prop}=${val}`;
    } else {
      this.queries += `&${prop}=${val}`;
    }
  }
  _resetQueries() {
    this.queries = undefined;
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

  generateQueries(quality) {
    if (this.width) this._addQuery("w", this.width);
    if (this.height) this._addQuery("h", this.height);

    if (quality) this._addQuery("q", quality);
    this._addQuery("auto", "format");

    if (this.source === ImageSource.unsplash) {
      this._addQuery("crop", "entropy");
      this._addQuery("fit", this.fit ?? "crop");
    } else if (this.source === ImageSource.pexels) {
      this._addQuery("cs", "tinysrgb");
      this._addQuery("fit", this.fit ?? "scale");
    }

    const queries = this.queries;
    this._resetQueries();
    return queries;
  }
  /**
   * Generates image url
   * @param {*} id : Image source Id
   * @param {*} defaultFileFormat the default file format (required for pexels API)
   */
  generate(id, quality, defaultFileFormat) {
    this._buildBaseURL(id, defaultFileFormat);
    this.generateQueries(quality);

    this.url += this.queries;
    this._resetQueries();

    return this.url;
  }
}

export default URLGenerator;

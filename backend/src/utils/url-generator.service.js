import { ImageSource } from "../models/constants.js";

class URLGenerator {
  constructor(source, width, height, fit) {
    this.source = source;
    this.width = width;
    this.height = height;
    this.fit = fit;
  }
  addQuery(prop, val) {
    if (!this.queries || this.queries.length === 0) {
      this.queries = `${prop}=${val}`;
    } else {
      this.queries += `&${prop}=${val}`;
    }
  }
  resetQueries() {
    this.queries = undefined;
  }

  buildBaseURL(id, fileName) {
    const { UNSPLASH_IMAGE_API_BASE_URL, PEXELS_IMAGE_API_BASE_URL } =
      process.env;
    this.didAddAnyQuery = false;
    if (this.source === ImageSource.unsplash) {
      this.url = `${UNSPLASH_IMAGE_API_BASE_URL}${id}`;
    } else if (this.source === ImageSource.pexels) {
      this.url = `${PEXELS_IMAGE_API_BASE_URL}${id}/${fileName}`;
    }
  }

  generateQueries(quality, auto, crop, cs) {
    if (this.width) this.addQuery("w", this.width);
    if (this.height) this.addQuery("h", this.height);

    if (quality) this.addQuery("q", quality);
    this.addQuery("auto", auto ?? "format");

    if (this.source === ImageSource.unsplash) {
      this.addQuery("crop", crop ?? "entropy");
      this.addQuery("fit", this.fit ?? "crop");
    } else if (this.source === ImageSource.pexels) {
      this.addQuery("cs", cs ?? "tinysrgb");
      this.addQuery("fit", this.fit ?? "scale");
    }

    const queries = this.queries;
    this.resetQueries();
    return queries;
  }
  /**
   * Generates image url
   * @param {*} id : Image source Id
   * @param {*} fileName file name (required for pexels API)
   */
  generate(id, quality, auto, crop, cs, fileName) {
    this.buildBaseURL(id, fileName);

    this.url += `?${this.generateQueries(quality, auto, crop, cs)}`;
    this.resetQueries();

    return this.url;
  }
}

export default URLGenerator;

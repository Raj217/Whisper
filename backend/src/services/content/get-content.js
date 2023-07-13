import ImageInfo from "../../models/image-info.js";
import URLGenerator from "../../utils/url-generator.service.js";
import Cipher from "../../utils/cipher-utils.service.js";
import { updateImageInfo } from "./utils/update-image-info.service.js";
import axios from "axios";

export const getContent = async (res, query) => {
  var { id, w, h, q, auto, crop, fit, cs } = query;

  const [imageID, purpose, src] = Cipher.decrypt(id);

  const urlGenerator = new URLGenerator(src, w, h, fit);
  const imageData = await ImageInfo.findById(imageID);

  const url = urlGenerator.generate(
    imageData.imageSourceID,
    q,
    auto,
    crop,
    cs,
    imageData.extra.defaultFileFormat
  );
  axios
    .get(url, { responseType: "stream" })
    .then((response) => {
      response.data.pipe(res);

      response.data.on("end", async () => {
        // Download completed
        await updateImageInfo(purpose, imageData);
      });
    })
    .catch((error) => {
      console.error("Error retrieving file:", error);
      res.statusCode = 500;
      res.end("Error retrieving file");
    });
};

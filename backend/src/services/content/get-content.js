import ImageInfo from "../../models/image-info.js";
import URLGenerator from "../../utils/url-generator.service.js";
import Cipher from "../../utils/cipher-utils.service.js";

export const getContent = async (query) => {
  var { id, w, h, q, auto, crop, fit, cs } = query;

  const [imageID, download, src] = Cipher.decrypt(id);

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
  console.log(url);
};

import ImageInfo from "../../models/image-info.js";
import URLGenerator from "../../utils/url-generator.service.js";
import Cipher from "../../utils/cipher-utils.js";

export const getContent = async (_id) => {
  console.log(Cipher.decrypt(_id));
  var { id, w, h, fm, fit, q, download, src } = Cipher.decrypt(_id);

  const urlGenerator = new URLGenerator(src, w, h, fm, fit, q);

  const imageData = await ImageInfo.findById(id);

  const url = urlGenerator.generate(
    imageData.id,
    imageData.extra.defaultFileFormat
  );

  if (download) {
  }
};

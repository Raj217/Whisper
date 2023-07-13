import { createCipheriv, randomBytes, createDecipheriv } from "crypto";

class Cipher {
  static encrypt(data) {
    const encodedFormat = "base64url";
    const { CIPHER_ALGORITHM, CIPHER_KEY } = process.env;

    const iv = randomBytes(16);
    const cipher = createCipheriv(CIPHER_ALGORITHM, CIPHER_KEY, iv);

    const encrypted =
      cipher.update(JSON.stringify(data), "utf8", encodedFormat) +
      cipher.final(encodedFormat);
    return iv.toString(encodedFormat) + encrypted;
  }
  static decrypt(encrypted) {
    const encodedFormat = "base64url";
    const { CIPHER_ALGORITHM, CIPHER_KEY } = process.env;
    const iv = Buffer.from(encrypted.slice(0, 22), encodedFormat);
    const decipher = createDecipheriv(CIPHER_ALGORITHM, CIPHER_KEY, iv);
    const decrypted =
      decipher.update(encrypted.slice(22), encodedFormat, "utf8") +
      decipher.final("utf8");
    return JSON.parse(decrypted);
  }
}

export default Cipher;

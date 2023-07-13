import { createCipheriv, randomBytes, createDecipheriv } from "crypto";

class Cipher {
  static encrypt(data) {
    const { CIPHER_ALGORITHM, CIPHER_KEY } = process.env;

    const iv = randomBytes(16);
    const cipher = createCipheriv(CIPHER_ALGORITHM, CIPHER_KEY, iv);
    const encrypted =
      cipher.update(JSON.stringify(data), "utf8", "hex") + cipher.final("hex");
    return iv.toString("hex") + encrypted;
  }
  static decrypt(encrypted) {
    const { CIPHER_ALGORITHM, CIPHER_KEY } = process.env;

    const iv = Buffer.from(encrypted.slice(0, 32), "hex");
    const decipher = createDecipheriv(CIPHER_ALGORITHM, CIPHER_KEY, iv);
    const decrypted =
      decipher.update(encrypted.slice(32), "hex", "utf8") +
      decipher.final("utf8");
    return JSON.parse(decrypted);
  }
}

export default Cipher;

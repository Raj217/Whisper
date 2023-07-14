import { firebase } from "../../firebase/utils.js";
import Exception, { ExceptionCodes } from "../../utils/exception.js";

class Transaction {
  async create(email, imageID) {
    const db = firebase.firestore();

    await db.collection(this.collectionName).add({
      email,
      imageID,
      createdAt: Date.now(),
    });
  }

  async get(uid, imageID) {
    const db = firebase.firestore();

    if (!uid && !imageID) {
      throw new Exception(
        "Either uid or imageID is required",
        ExceptionCodes.BAD_INPUT
      );
    }

    const collection = db.collection(this.collectionName);
    var res;
    if (uid) res = await collection.where("uid", "==", uid).get();
    else res = await collection.where("imageID", "==", imageID).get();

    return res;
  }
}

export default Transaction;

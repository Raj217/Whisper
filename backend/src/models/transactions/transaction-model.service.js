import { firebase } from "../../firebase/utils";
import Exception, { ExceptionCodes } from "../../utils/exception.js";

class Transaction {
  async create(uid, imageID) {
    const db = firebase.firestore();

    await db.collection(this.collectionName).add({
      uid,
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
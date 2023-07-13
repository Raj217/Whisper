import { firebase } from "../firebase/utils.js";

class User {
  static userCollectionName = "users";
  static async create(data) {
    const { firstName, lastName, email, emailVerified, uuid } = data;
    const db = firebase.firestore();

    const userData = {
      firstName,
      lastName,
      email,
      emailVerified,
    };

    await db.collection(User.userCollectionName).doc(uuid).set(userData);
  }
  static async findByUID(uid) {
    const db = firebase.firestore();
    return await db.collection(User.userCollectionName).doc(uid).get();
  }
  static async findByEmail(email) {
    const db = firebase.firestore();
    const snapshot = await db
      .collection(User.userCollectionName)
      .where("email", "==", email)
      .limit(1)
      .get();
    if (snapshot.empty) {
      return null;
    } else {
      return snapshot.docs[0];
    }
  }
}

export default User;

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
  static async find(uid) {
    const db = firebase.firestore();
    return await db.collection(User.userCollectionName).doc(uid).get();
  }
}

export default User;

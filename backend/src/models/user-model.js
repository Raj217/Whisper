import { firebase } from "../firebase/utils.js";

class User {
  static userCollectionName = "users";
  static async create(data) {
    const { firstName, lastName, email, emailVerified } = data;
    const db = firebase.firestore();

    const userData = {
      firstName,
      lastName,
      emailVerified,
    };

    await db.collection(User.userCollectionName).doc(email).set(userData);
  }
  static async find(email) {
    const db = firebase.firestore();
    return await db.collection(User.userCollectionName).doc(email).get();
  }
}

export default User;

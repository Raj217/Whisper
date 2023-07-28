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
      randomImagesLastViewedCheckpoint: 0,
    };

    await db.collection(User.userCollectionName).doc(email).set(userData);
  }
  static async find(email) {
    const db = firebase.firestore();
    return await db.collection(User.userCollectionName).doc(email).get();
  }
  static async update(user, email) {
    const db = firebase.firestore();
    await db.collection(User.userCollectionName).doc(email).set(user);
  }
  static async updateLastViewed(lastViewed, email) {
    const user = (await User.find(email)).data();
    const prevLastViewed = user["randomImagesLastViewedCheckpoint"] ?? 0;
    user["randomImagesLastViewedCheckpoint"] = Math.max(
      prevLastViewed,
      lastViewed
    );
    await User.update(user, email);
  }
}

export default User;

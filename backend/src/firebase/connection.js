import { initializeApp, credential } from "firebase-admin";

export default firebase = initializeApp({
  credential: credential.cert({
    projectId: process.env.FIREBASE_PROJECT_ID,
    clientEmail: process.env.FIREBASE_CLIENT_EMAIL,
    projectKey: process.env.FIREBASE_PROJECT_KEY,
  }),
});

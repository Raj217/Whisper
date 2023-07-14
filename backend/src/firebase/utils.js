import { OAuth2Client } from "google-auth-library";
import admin from "firebase-admin";
import credentials from "../../etc/secrets/firebase.json" assert { type: "json" };
import Exception, { ExceptionCodes } from "../utils/exception.js";

export const getUserDetails = async (idToken) => {
  const { FIREBASE_CLIENT_ID } = process.env;

  const client = new OAuth2Client(FIREBASE_CLIENT_ID);

  var ticket;
  try {
    ticket = await client.verifyIdToken({
      idToken,
      audience: FIREBASE_CLIENT_ID,
    });
  } catch (err) {
    const tokenExpiredErrorMessage = "Token used too late";
    if (
      err.message.substring(0, tokenExpiredErrorMessage.length) ===
      tokenExpiredErrorMessage
    ) {
      throw new Exception("Token Expired", ExceptionCodes.UNAUTHORIZED);
    }
  }

  return ticket.getPayload();
};

export const firebase = admin.initializeApp({
  credential: admin.credential.cert(credentials),
});

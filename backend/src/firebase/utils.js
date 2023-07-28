import { OAuth2Client } from "google-auth-library";
import admin from "firebase-admin";
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
    } else {
      throw new Exception(err.message, ExceptionCodes.INTERNAL_SERVER_ERROR);
    }
  }

  return ticket.getPayload();
};

export const firebase = admin.initializeApp({
  credential: admin.credential.cert({
    type: process.env.FIREBASE_CREDENTIALS_TYPE,
    project_id: process.env.FIREBASE_CREDENTIALS_PROJECT_ID,
    private_key_id: process.env.FIREBASE_CREDENTIALS_PROJECT_KEY_ID,
    private_key: process.env.FIREBASE_CREDENTIALS_PRIVATE_KEY,
    client_email: process.env.FIREBASE_CREDENTIALS_CLIENT_EMAIL,
    client_id: process.env.FIREBASE_CREDENTIALS_CLIENT_ID,
    auth_uri: process.env.FIREBASE_CREDENTIALS_AUTH_URI,
    token_uri: process.env.FIREBASE_CREDENTIALS_TOKEN_URI,
    auth_provider_x509_cert_url:
      process.env.FIREBASE_CREDENTIALS_AUTH_X509_CERT_URL,
    client_x509_cert_url: process.env.FIREBASE_CREDENTIALS_CLIENT_X509_CERT_URL,
    universe_domain: process.env.FIREBASE_CREDENTIALS_UNIVERSE_DOMAIN,
  }),
});

import { OAuth2Client } from "google-auth-library";

export const getUserDetails = async (idToken) => {
  const { FIREBASE_CLIENT_ID } = process.env;

  const client = new OAuth2Client(FIREBASE_CLIENT_ID);
  
  const ticket = await client.verifyIdToken({
    idToken,
    audience: FIREBASE_CLIENT_ID,
  });

  return ticket.getPayload();
};

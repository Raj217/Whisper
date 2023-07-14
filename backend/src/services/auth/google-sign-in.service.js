import { getUserDetails } from "../../firebase/utils.js";
import Exception, { ExceptionCodes } from "../../utils/exception.js";
import User from "../../models/user-model.js";
import generateToken from "./utils/generate-token.js";

export const googleSignIn = async (body) => {
  const { idToken } = body;
  if (!idToken) {
    throw new Exception("idToken is required", ExceptionCodes.BAD_INPUT);
  }

  const userData = await getUserDetails(idToken);

  const email = userData.email;
  var existingUser = await User.find(email);
  var emailVerified = true;

  if (!existingUser.exists) {
    emailVerified = userData.email_verified;
    await User.create({
      firstName: userData.given_name,
      lastName: userData.family_name,
      email,
      emailVerified,
    });
  }

  return { token: generateToken(email, emailVerified) };
};

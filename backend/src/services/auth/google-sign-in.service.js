import { getUserDetails } from "../../firebase/utils.js";
import Exception, { ExceptionCodes } from "../../utils/exception.js";
import User from "../../models/user-model.js";
import generateToken from "./utils/generate-token.js";

export const googleSignIn = async (idToken) => {
  if (!idToken) {
    throw new Exception("idToken is required", ExceptionCodes.BAD_INPUT);
  }

  const userData = await getUserDetails(idToken);

  const email = userData.email;
  var existingUser = await User.findOne({ email });
  var emailVerified = true;

  if (!existingUser) {
    emailVerified = userData.email_verified;
    await User.create({
      email,
      emailVerified,
      firstName: userData.given_name,
      lastName: userData.family_name,
    });
  }

  return { token: generateToken(email, emailVerified) };
};

import { getUserDetails } from "../../firebase/utils.js";
import Exception, { ExceptionCodes } from "../../utils/error.js";
import User from "../../models/user_model.js";
import generateToken from "./utils/generate_token.js";

export const googleSignIn = async (idToken) => {
  if (!idToken) {
    throw new Exception("idToken is required", ExceptionCodes.BAD_INPUT);
  }

  const userData = await getUserDetails(idToken);

  const email = userData.email;
  var existingUser = await User.findOne({ email });

  if (!existingUser) {
    await User.create({
      email,
      emailVerified: userData.email_verified,
      firstName: userData.given_name,
      lastName: userData.family_name,
    });
  }

  return { token: generateToken(email) };
};

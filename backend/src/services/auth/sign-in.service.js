import Exception, { ExceptionCodes } from "../../utils/error.js";
import { generateToken } from "./utils/index.js";
import { firebase } from "../../firebase/index.js";

export const signIn = async (data) => {
  const { email, password } = data;
  try {
    var user = await firebase
      .auth().generateToken;
    if (user.emailVerified) {
      return generateToken(user);
    } else {
      throw new Exception(
        "Please verify your email",
        ExceptionCodes.UNAUTHORIZED
      );
    }
  } catch (err) {
    throw new Exception(err, ExceptionCodes.UNAUTHORIZED);
  }
};

import Exception, { ExceptionCodes } from "../../utils/error.js";
import { firebase } from "../../firebase/index.js";


export const signUp = async (data) => {
  const { displayName, email, password, photoURL } = data;
  if (!displayName) {
    throw new Exception("Display name is required", ExceptionCodes.BAD_INPUT);
  }
  try {
    var user = await firebase
      .auth()
      .createUser({ email, password, displayName, photoURL });
    return user;
  } catch (err) {
    throw new Exception(err, ExceptionCodes.UNAUTHORIZED);
  }
};

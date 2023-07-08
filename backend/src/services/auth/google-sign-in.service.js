import { getUserDetails } from "../../firebase/utils.js";
import Exception, { ExceptionCodes } from "../../utils/error.js";

export const googleSignIn = async (idToken) => {
  if (!idToken) {
    throw new Exception("idToken is required", ExceptionCodes.BAD_INPUT);
  }

  const userData = await getUserDetails(idToken);
  return userData;
};

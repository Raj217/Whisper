import prisma from "../../prisma";
import Exception, { ExceptionCodes } from "../../utils/error";
import Validator from "../../utils/validator";

export const signIn = async (data) => {
  const { email, password } = data;

  userData = {};
  if (!email) {
    throw new Exception("Email is required", ExceptionCodes.BAD_INPUT);
  }
  if (!Validator.isValidEmail(email)) {
    throw new Exception("Email is not valid", ExceptionCodes.UNAUTHORIZED);
  } else {
    userData = { email };
  }

  const existingUser = await prisma.user.findFirst({ where: { email } });

  if (!existingUser) {
    throw new Exception("User not found", ExceptionCodes.NOT_FOUND);
  }
  if (!existingUser.isOAuth && !password) {
    throw new Exception("")
  }
};

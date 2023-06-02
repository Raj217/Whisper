import Exception, { ExceptionCodes } from "../../utils/error.js";
import Validator from "../../utils/validator.js";
import prisma from "../../prisma/index.js";
import bcrypt from "bcrypt";
import { generateToken, removeSecrets } from "./utils/index.js";
import { OAuth2Client } from "google-auth-library";

export const signUp = async (user) => {
  const { firstName, lastName, email, password, isOAuth, authId } = user;
  var userData = {};

  // Validate if all the required fields are present
  if (isOAuth === false) {
    if (!firstName) {
      throw new Exception("First name is required", ExceptionCodes.BAD_INPUT);
    } else {
      userData = { ...userData, firstName: firstName };
    }
    if (lastName) {
      userData = { ...userData, lastName: lastName };
    }
    if (!email) {
      throw new Exception("Email is required", ExceptionCodes.BAD_INPUT);
    }
    if (!Validator.isValidEmail(email)) {
      throw new Exception("Invalid email", ExceptionCodes.UNAUTHORIZED);
    } else {
      userData = { ...userData, email: email };
    }
    if (!password) {
      throw new Exception("Password is required", ExceptionCodes.BAD_INPUT);
    }
    if (password.length < 6) {
      throw new Exception(
        "Password must be at least 6 characters",
        ExceptionCodes.BAD_INPUT
      );
    } else {
      userData = { ...userData, password: password };
    }
  } else {
    const client = OAuth2Client(process.env.CLIENT_ID);
    const ticket = await client.verifyIdToken({
      idToken: authId,
      audience: process.env.CLIENT_ID,
    });

    const { name, email, profileImageUrl } = ticket.getPayload();
    userData = {
      firstName: name,
      email,
      profileImageUrl,
    };
  }

  const existingUser = await prisma.user.findFirst({
    where: { email: userData.email },
  });

  /// Already someone exists with the same email
  if (existingUser && existingUser.isEmailVerified === false) {
    throw new Exception(
      "User already exists. But your email is not verified, please verify it.",
      ExceptionCodes.CONFLICT
    );
  } else if (existingUser) {
    throw new Exception(
      "User already exists. Please Sign in.",
      ExceptionCodes.CONFLICT
    );
  }

  userData = { ...userData, isOAuth: isOAuth, isEmailVerified: isOAuth };
  if (!isOAuth) {
    /// New user thus hash the password
    const hashedPassword = await bcrypt.hash(
      password,
      parseInt(process.env.SALT_ROUNDS)
    );
    userData = { ...userData, password: hashedPassword };
  }

  const exisistingUser = await prisma.user.create({ data: userData });

  if (isOAuth) {
    return {
      user: removeSecrets(exisistingUser),
      token: generateToken(exisistingUser),
      message: process.env.WELCOME_MESSAGE,
    };
  } else {
    return {
      message: "Please verify your email address.",
    };
  }
};

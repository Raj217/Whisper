import jwt from "jsonwebtoken";

export default (email, emailVerified) => {
  const { JWT_SECRET, JWT_EXPIRY } = process.env;
  return jwt.sign(
    {
      email,
      emailVerified,
    },
    JWT_SECRET,
    {
      expiresIn: JWT_EXPIRY,
    }
  );
};

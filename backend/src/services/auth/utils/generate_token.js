import jwt from "jsonwebtoken";

export default (email) => {
  const { JWT_SECRET, JWT_EXPIRY } = process.env;
  return jwt.sign(
    {
      email,
    },
    JWT_SECRET,
    {
      expiresIn: JWT_EXPIRY,
    }
  );
};

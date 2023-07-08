import json from "jsonwebtoken";

export const generateToken = (user) => {
  const payload = {
    email: user.email,
  };
  const secret = process.env.JWT_SECRET;
  const props = {
    expiresIn: process.env.JWT_EXPIRY,
  };
  return json.sign(payload, secret, props);
};

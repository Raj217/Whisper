import { Schema, model } from "mongoose";

const userSchema = new Schema(
  {
    firstName: { type: String, required: true },
    lastName: { type: String },
    email: { type: String, required: true },
    password: { type: String, select: false },
    emailVerified: { type: Boolean, required: true, default: false },
  },
  { timestamps: true }
);

export default model("User", userSchema);

import { Schema, model } from "mongoose";

const tagSchema = new Schema(
  {
    tag: { type: String, required: true, unique: true },
    unsplashScraped: { type: Number, default: 0 },
    pexelsScraped: { type: Number, default: 0 },
  },
  { timestamps: true }
);

export default model("Tag", tagSchema);

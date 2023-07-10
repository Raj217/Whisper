import { Schema, model } from "mongoose";

const tagSchema = new Schema({
  tag: { type: String, required: true },
  unsplashScraped: { type: Number, default: 0 },
  pexelsScraped: { type: Number, default: 0 },
});

export default model("Tag", tagSchema);

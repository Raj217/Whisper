import { Schema, model } from "mongoose";

const tagSchema = new Schema(
  {
    tag: { type: String, required: true, unique: true },
    didFinishScrapingUnsplash: { type: Boolean, default: false },
    didFinishScrapingPexels: { type: Boolean, default: false },
    ids: [{ type: Schema.ObjectId }],
  },
  { timestamps: true }
);

export default model("Tag", tagSchema);

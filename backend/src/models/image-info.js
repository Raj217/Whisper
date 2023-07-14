import { Schema, model, SchemaTypes } from "mongoose";
import { ImageSource } from "./constants.js";

const imageInfoSchema = new Schema(
  {
    imageSourceID: { type: String, required: true, unique: true },
    publisherName: { type: String },
    publisherUrl: { type: String },
    tags: [{ type: String }],
    color: { type: String },
    source: { type: String, enum: ImageSource, required: true },
    extra: {
      fileName: { type: String },
    },
    views: { type: Number, default: 0 },
    downloads: { type: Number, default: 0 },
  },
  { timestamps: true }
);

export default model("ImageInfo", imageInfoSchema);

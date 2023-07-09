import { Schema, model, SchemaTypes } from "mongoose";
import { ImageSource } from "./constants.js";

const imageInfoSchema = new Schema(
  {
    imageSourceID: { type: String, required: true },
    publisherName: { type: String },
    publisherUrl: [
      {
        type: String,
        match:
          "/(ftp|http|https)://(w+:{0,1}w*@)?(S+)(:[0-9]+)?(/|/([w#!:.?+=&%@!-/]))?/",
      },
    ],
    tags: [{ type: String }],
    source: { type: String, enum: ImageSource, required: true },
    views: { type: Number, default: 0 },
    downloads: { type: Number, default: 0 },
  },
  { timestamps: true }
);

export default model("ImageInfo", imageInfoSchema);

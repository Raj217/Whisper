import { Schema, model } from "mongoose";
import { ImageSource } from './constants.js';

const imageInfoSchema = new Schema({
  imageSourceID: { type: String, required: true },
  owner: [{ type: String }],
  tags: [{ type: String }],
  source: {type: String, enum: ImageSource, required: true },
}, {timestamps: true});


export default model("ImageInfo", imageInfoSchema);
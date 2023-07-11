import { Schema, model } from "mongoose";

const apiStateSchema = new Schema(
  {
    isMaintainanceActive: { type: Boolean, default: false },
    currentlyScraping: { type: String },
    tagsToScrape: { type: [String], unique: true },
    unsplashScraped: { type: Number },
    pexelsScraped: { type: Number },
  },
  { timestamps: true }
);

export default model("ApiState", apiStateSchema);

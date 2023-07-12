import { Schema, model } from "mongoose";

const apiStateSchema = new Schema(
  {
    isMaintainanceActive: { type: Boolean, default: false },
    currentlyScraping: { type: String },
    tagsToScrape: [{ type: String }],
    // I know page no won't be good for new but will lead to performance issues
    // The new ones will be added later
    unsplashPage: { type: Number, default: 0 },
    pexelsPage: { type: Number, default: 0 },
  },
  { timestamps: true }
);

export default model("ApiState", apiStateSchema);

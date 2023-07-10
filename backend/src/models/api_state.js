import { Schema, model } from "mongoose";

const apiStateSchema = new Schema({
  isMaintainanceActive: { type: Boolean, default: false },
  tagsScraped: [{ type: String }],
  currentlyScraping: { type: String },
  unsplashPageNo: { type: Number },
  pexelsPageNo: { type: Number },
});

export default model("ApiState", apiStateSchema);

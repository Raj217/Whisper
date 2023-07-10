import { Schema, model } from "mongoose";

const apiStateSchema = new Schema(
  {
    isMaintainanceActive: { type: Boolean, default: false },
    currentlyScraping: { type: String },
    unsplashPageNo: { type: Number },
    pexelsPageNo: { type: Number },
  },
  { timestamps: true }
);

export default model("ApiState", apiStateSchema);

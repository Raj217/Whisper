import { Schema, model } from "mongoose";

const imageUsedTransactionSchema = new Schema(
  {
    userId: { type: String, required: true },
    imageId: { type: String, required: true },
  },
  { timestamps: true }
);

export default model("ImageUsedTransactionSchema", imageUsedTransactionSchema);
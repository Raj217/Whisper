import mongoose from "mongoose";
import * as dotenv from "dotenv";
dotenv.config();

const { DATABASE_URL } = process.env;

/// Couldn't find MONGO_URI in env
if (DATABASE_URL === undefined) {
  console.log("Couldn't find mongo uri. Exiting now... ");
  process.exit(0);
}

export const connect = () => {
  // Connect to database
  mongoose
    .connect(DATABASE_URL)
    .then(() =>
      console.log(`Successfully Connected to database at ${DATABASE_URL}`)
    )
    .catch((err) => {
      console.log("Database connection failed. Due to  ");
      console.error(err);
      console.log("Exiting now... ");
      process.exit(0);
    });
};

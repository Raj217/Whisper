import mongoose from "mongoose";
import * as dotenv from "dotenv";
import APIState from "../models/api-state.js";
dotenv.config();

const { DATABASE_URL } = process.env;

export const connect = () => {
  // Connect to database
  mongoose
    .connect(DATABASE_URL)
    .then(async () => {
      console.log(`Successfully Connected to database at ${DATABASE_URL}`);
      var state = await APIState.findOne();
      if (!state) {
        await APIState.create({
          isMaintainanceActive: false,
        });
        console.log("Created APIState");
      } else {
        console.log("No new instance of APIState created");
      }
    })
    .catch((err) => {
      console.log("Database connection failed. Due to  ");
      console.error(err);
      console.log("Exiting now... ");
      process.exit(0);
    });
};

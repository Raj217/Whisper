import express from "express";
import devRoute from "./routes/index.js";
import { logger } from "./middlewares/logger.js";
import { defaultExceptionHandler } from "./middlewares/exception_handler.js";
import * as dotenv from "dotenv";
dotenv.config();

const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(logger);

app.use("/api/v0", devRoute);

app.use(defaultExceptionHandler);

app.listen(process.env.API_PORT, () => {
  console.log("Listening on port 3000");
});

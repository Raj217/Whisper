import dotenv from "dotenv";
import express from "express";
import devRoute from "./src/routes/index.js";
import { logger } from "./src/middlewares/logger.js";
import { defaultExceptionHandler } from "./src/middlewares/exception_handler.js";

dotenv.config();
const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(logger);

app.use("/api/v0", devRoute);
app.use(defaultExceptionHandler);

app.listen(process.env.PORT_NO, () => {
  console.log(`Listening on port ${process.env.PORT_NO}`);
});

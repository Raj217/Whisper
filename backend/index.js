import express from "express";
import { logger } from "./src/middlewares/logger.js";
import { defaultExceptionHandler } from "./src/middlewares/exception-handler.js";
import * as db from "./src/db/database.js";
import devRoute from "./src/routes/index.js";
import  "./src/extensions/logging.service.js";

db.connect();
const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(logger);

app.use("/api/v0", devRoute);
app.use(defaultExceptionHandler);

app.listen(process.env.PORT_NO, () => {
  console.log(`Listening on port ${process.env.PORT_NO}`);
});

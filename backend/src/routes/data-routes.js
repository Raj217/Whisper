import { Router } from "express";
import * as DataController from "../controllers/data-controller.js";

const router = Router();

router.get("/add", DataController.add);

export default router;

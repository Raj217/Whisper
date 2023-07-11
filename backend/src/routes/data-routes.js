import { Router } from "express";
import * as DataController from "../controllers/data-controller.js";

const router = Router();

router.get("/add", DataController.add);
router.get("/chain-add", DataController.chainAdd);
router.get("/stop", DataController.stop);
router.get("/state", DataController.state);

export default router;

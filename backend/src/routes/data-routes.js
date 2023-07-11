import { Router } from "express";
import * as DataController from "../controllers/data-controller.js";

const router = Router();

router.post("/add", DataController.add);
router.post("/chain-add", DataController.chainAdd);
router.get("/stop-chain", DataController.stopChain);
router.get("/state", DataController.state);

export default router;

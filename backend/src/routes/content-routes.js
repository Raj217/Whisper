import { Router } from "express";
import * as ContentController from "../controllers/content-controller.js";

const router = Router();

router.get("/", ContentController.getContent);

export default router;

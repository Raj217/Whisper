import { Router } from "express";
import * as SearchController from "../controllers/search-controller.js";

const router = Router();

router.get('/', SearchController.search);

export default router;

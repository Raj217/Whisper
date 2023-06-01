import { Router } from "express";
import * as AuthController from "../controllers/auth-controller.js";

const router = Router();

router.post("/sign-up", AuthController.signUp);

export default router;

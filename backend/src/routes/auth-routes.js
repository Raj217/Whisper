import { Router } from "express";
import * as AuthController from "../controllers/auth-controller.js";

const router = Router();

router.post("/google-sign-in", AuthController.googleSignIn);

export default router;

import express from "express";
import WelcomeRoutes from "./welcome-routes.js";
import AuthRoutes from "./auth-routes.js";
import DataRoutes from "./data-routes.js";
import { verifyToken } from "../middlewares/auth.js";
import { maintainance } from "../middlewares/maintainance.js";
import { adminCheck } from "../middlewares/admin_check.js";

const router = express.Router();

router.use("/auth", AuthRoutes);
router.use("/welcome", WelcomeRoutes);
router.use("/data", verifyToken, adminCheck, DataRoutes);

export default router;

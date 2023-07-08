import express from "express";
import WelcomeRoutes from "./welcome-routes.js";
import AuthRoutes from "./auth-routes.js";
import SearchRoutes from "./search-routes.js";
import { verifyToken } from "../middlewares/auth.js";

const router = express.Router();

router.use("/auth", AuthRoutes);
router.use("/welcome", WelcomeRoutes);
router.use("/search", verifyToken, SearchRoutes);

export default router;

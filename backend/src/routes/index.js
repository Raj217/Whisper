import express from "express";
import WelcomeRoutes from "./welcome-routes.js";
import AuthRoutes from "./auth-routes.js";
import DataRoutes from "./data-routes.js";
import SearchRoutes from "./search-routes.js";
import {
  verifyToken,
  maintainance,
  adminCheck,
  searchPagination,
} from "../middlewares/index.js";

const router = express.Router();

router.use("/auth", AuthRoutes);
router.use("/welcome", WelcomeRoutes);
router.use("/data", verifyToken, adminCheck, DataRoutes);
router.use("/search", verifyToken, maintainance, searchPagination, SearchRoutes);

export default router;

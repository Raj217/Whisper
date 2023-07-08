import  express  from 'express';
import WelcomeRoutes from "./welcome-routes.js";
import AuthRoutes from "./auth-routes.js";
import SearchRoutes from "./search-routes.js";

const router = express.Router();

router.use("/auth", AuthRoutes);
router.use("/welcome", WelcomeRoutes);
router.use("/search", SearchRoutes);

export default router;
import  express  from 'express';
import Welcome from "./welcome-routes.js";
import AuthRoutes from "./auth-routes.js";

const router = express.Router();

router.use("/auth/", AuthRoutes);
router.use("/welcome/", Welcome);

export default router;
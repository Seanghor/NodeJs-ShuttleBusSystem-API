import { Router } from "express";
import subLocation from "./subLocation.controller";
import { authorizeAdmin } from "../../middleware/authorize";
export default () => {
  const router: Router = Router();
  router.get("/", subLocation.getAllSubLocationController);
  router.get("/:id", subLocation.getSubLocationByIdController);
  router.get(
    "/mainLocation/filter",
    authorizeAdmin,
    subLocation.getAllSubLocationFilterByMainLocIdController
  );
  router.get(
    "/mainLocation/enableStatus/filter",
    authorizeAdmin,
    subLocation.getAllSubLocationFilterByMainLocIdAdnEnableStatusController
  );
  router.post("/", authorizeAdmin, subLocation.createSubLocationController);
  router.put("/:id", authorizeAdmin, subLocation.updateSubLocationController);
  router.put(
    "/enableStatus/:id",
    authorizeAdmin,
    subLocation.updateEnableStatusOfSubLocationController
  );
  router.delete(
    "/:id",
    authorizeAdmin,
    subLocation.deleteSubLocationController
  );
  return router;
};

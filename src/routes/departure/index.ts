import { authorizeAdmin } from "./../../middleware/authorize";
import { Router } from "express";
import departure from "./departure.controller";

export default () => {
  const router: Router = Router();
  router.get("/", departure.getAllDepartureController);
  router.get(
    "/enableStatus/filter",
    authorizeAdmin,
    departure.getAllDepartureControllerFilterByEnableStatus
  );
  router.get("/:id", departure.getDepartureByIdController);
  router.post("/", authorizeAdmin, departure.createDepartureController);
  router.put("/:id", authorizeAdmin, departure.updateDepartureByIdController);
  router.put(
    "/enableStatus/:id",
    authorizeAdmin,
    departure.updateDepartureStatusByIdController
  );
  router.delete("/:id", authorizeAdmin, departure.deleteDepartureController);
  return router;
};

import { authorizeUser } from "./../../middleware/authorize";
import { Router } from "express";
import bus from "./bus.controller";
import { authorizeAdmin } from "../../middleware/authorize";

export default () => {
  const router: Router = Router();
  router.post("/", authorizeAdmin, bus.createBusController);
  router.get("/", authorizeAdmin, bus.getAllBusController);
  router.get(
    "/enableStatus/filter",
    authorizeAdmin,
    bus.getAllBusFilterByEnableStatusController
  );
  router.get("/:id", authorizeAdmin, authorizeUser, bus.getBusByIdController);
  router.put("/:id", authorizeAdmin, bus.updateBusController);
  router.put(
    "/enableStatus/:id",
    authorizeAdmin,
    bus.updateEnableStatusOfBusController
  );
  router.delete("/:id", authorizeAdmin, bus.deleteBusController);
  return router;
};

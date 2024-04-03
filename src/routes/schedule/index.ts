import { Router } from "express";
import schedule from "./schedule.controller";
import { authorizeAdmin, authorizeUser } from "../../middleware/authorize";
const uploadFile = require("multer")();

export default () => {
  const router: Router = Router();
  router.post(
    "/import",
    uploadFile.single("file"),
    authorizeAdmin,
    schedule.BatchCreateScheduleController
  );
  router.get("/", authorizeAdmin, schedule.getAllScheduleController);
  router.get(
    "/enableStatus/filter",
    authorizeUser,
    schedule.getAllScheduleFilterByEnableStatusController
  );
  router.get(
    "/date/filter",
    authorizeUser,
    schedule.getAllScheduleFilterByDateController
  );
  router.post("/", authorizeAdmin, schedule.createScheduleController);
  router.get("/:id", schedule.getScheduleByIdController);
  router.get(
    "/year/month/filter",
    schedule.getAllScheduleFilterByYearAndMonthController
  );
  router.put("/:id", authorizeAdmin, schedule.updateScheduleByIdController);
  router.put(
    "/confirm/:id",
    authorizeAdmin,
    schedule.confirmScheduleController
  ); // user query: confirm={status}
  router.delete("/:id", authorizeAdmin, schedule.deleteScheduleByIdController);
  router.post("/block-seat/:id", authorizeAdmin, schedule.blockSeatController);
  router.delete(
    "/unblock-seat/filter",
    authorizeAdmin,
    schedule.unblockSeatController
  ); // user query: guestId={guestId} && scheduleId={scheduleId}
  router.put(
    "/block-seat/filter",
    authorizeAdmin,
    schedule.updateBlockSeatInfoController
  ); // user query: guestId={guestId} && scheduleId={scheduleId}
  return router;
};

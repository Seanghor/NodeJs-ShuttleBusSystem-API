import { Router } from "express";
import user from "./user.controller";
import { authForget } from "../../middleware/forgetauth";
import { authMiddleware } from "../../middleware/auth";
import {
  authorizeAdmin,
  authorizeSuperAdminOnly,
} from "../../middleware/authorize";
const uploadFile = require("multer")();

export default () => {
  const router: Router = Router();
  // GET
  router.get("/pdf?", authMiddleware, authorizeAdmin, user.exportAllUser);
  router.get(
    "/pdf-test",
    authMiddleware,
    authorizeAdmin,
    user.testingGeneratePDFController
  );

  router.get("/:id", authMiddleware, user.getUserByIdController);
  router.get(
    "/request/reset-password/:token",
    authForget,
    user.getTemplateResetPasswordWithTokenController
  );
  router.get(
    "/request/reset-password/:token",
    authForget,
    user.getTemplateResetPasswordWithTokenController
  );
  router.get("/", authMiddleware, authorizeAdmin, user.getAllUserController);
  router.get(
    "/department/batch/filter",
    authMiddleware,
    authorizeAdmin,
    user.getStudentByDeptAndBatchController
  );

  // POST:
  router.post("/", authMiddleware, authorizeAdmin, user.createUserController);
  router.post("/login/vkclub", user.loginVKclubController);
  router.post("/login/user", user.loginController);
  router.post("/login/admin", user.loginAdminController);
  router.post("/login/vk_club", user.loginAdminController);
  router.post("/request/reset-password", user.requestResetPasswordController);
  router.post(
    "/request/reset-password/admin",
    user.requestResetPasswordAdminController
  );
  router.post(
    "/request/reset-password/:token",
    authForget,
    user.confirmResetPasswordWithTokenController
  );
  router.post("/register", user.registerController);
  router.post(
    "/change-password",
    authMiddleware,
    user.changePasswordController
  );
  router.post(
    "/import",
    authMiddleware,
    uploadFile.single("file"),
    authorizeAdmin,
    user.importUser
  );
  router.post(
    "/wishing-mail",
    authMiddleware,
    authorizeAdmin,
    user.wishingMailController
  );

  // PUT:
  router.put("/:id", authMiddleware, authorizeAdmin, user.updateUserController);
  router.put(
    "/update/enableStatus/role/filter?",
    authMiddleware,
    authorizeAdmin,
    user.handleEnableAllUserByRoleController
  );
  router.put(
    "/update/enableStatus/batchId/filter?",
    authMiddleware,
    authorizeAdmin,
    user.handleEnableStudentOfDeptAndBatchByBatchIdController
  );
  router.put(
    "/update/enableStatus/student-staff/filter?",
    authMiddleware,
    authorizeAdmin,
    user.handleEnableStaffAndStudetByUserIdController
  );
  router.put(
    "/update/enableStatus/admin/filter?",
    authMiddleware,
    authorizeSuperAdminOnly,
    user.handleEnableAdminByUserIdController
  );

  // DELETE:
  router.delete(
    "/:id",
    authMiddleware,
    authorizeAdmin,
    user.deleteUserController
  );
  router.put(
    "/update/department-batch/filter",
    authMiddleware,
    authorizeAdmin,
    user.handleEnableStudentByBatchController
  );
  return router;
};

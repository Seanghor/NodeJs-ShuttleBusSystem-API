import { NextFunction, Request, Response } from "express";
import {
  SubLocationDto,
  UpdateSubLocationDto,
} from "../../payload/request/subLocatonDto";
import { respone } from "../../payload/respone/defaultRespone";
import subLocationService from "./subLocation.service";
import { CustomError } from "../../handler/customError";
import {
  loggerError,
  loggerInfo,
  loggerWarn,
} from "../../config/logger/customeLogger";
async function createSubLocationController(
  req: Request,
  res: Response,
  next: NextFunction
) {
  let controllerName = createSubLocationController.name;
  try {
    const subLocationDto = req.body as SubLocationDto;
    if (subLocationDto.subLocationName == null) {
      throw new CustomError(400, `subLocationName is required`);
    }
    if (subLocationDto.mainLocationId == null) {
      throw new CustomError(400, `mainLocationId is required`);
    }
    const subLocation = await subLocationService.createSubLocationService(
      subLocationDto
    );
    respone(res, subLocation, `Sub location create successful`, 200);
    loggerError(req, controllerName, res.statusCode, "Success");
  } catch (error: any) {
    console.log("Error status:", error.statusCode);
    if (error.statusCode === 500) {
      loggerError(req, controllerName, error.statusCode, error);
    } else {
      loggerWarn(req, controllerName, error.statusCode, error);
    }
    next(error);
  }
}

async function getSubLocationByIdController(
  req: Request,
  res: Response,
  next: NextFunction
) {
  let controllerName = getSubLocationByIdController.name;
  try {
    const { id } = req.params;
    const subLocations = await subLocationService.getSubLocationByIdService(id);
    respone(res, subLocations, `Get subLocation success`, 200);
    loggerInfo(req, controllerName, res.statusCode, "Success");
  } catch (error: any) {
    console.log("Error status:", error.statusCode);
    if (error.statusCode === 500) {
      loggerError(req, controllerName, error.statusCode, error);
    } else {
      loggerWarn(req, controllerName, error.statusCode, error);
    }
    next(error);
  }
}
async function getAllSubLocationFilterByMainLocIdController(
  req: Request,
  res: Response,
  next: NextFunction
) {
  let controllerName = getAllSubLocationFilterByMainLocIdController.name;
  try {
    const mainId = req.query.mainLocationId as string;
    console.log("-- query --", mainId);
    const subLocation =
      await subLocationService.getSubLocationByMainLocationIdService(mainId);
    respone(
      res,
      subLocation,
      `Get all subLocation filter by mainLocationId success`,
      200
    );
    loggerInfo(req, controllerName, res.statusCode, "Success");
  } catch (error: any) {
    console.log("Error status:", error.statusCode);
    if (error.statusCode === 500) {
      loggerError(req, controllerName, error.statusCode, error);
    } else {
      loggerWarn(req, controllerName, error.statusCode, error);
    }
    next(error);
  }
}

async function getAllSubLocationFilterByMainLocIdAdnEnableStatusController(
  req: Request,
  res: Response,
  next: NextFunction
) {
  let controllerName =
    getAllSubLocationFilterByMainLocIdAdnEnableStatusController.name;
  try {
    const mainId = req.query.mainLocationId as string;
    const enableStatus = req.query.enable as string;
    console.log("-- query enable ---", enableStatus);
    if (enableStatus !== "true" && enableStatus !== "false") {
      throw new CustomError(400, "enable must be type of boolean");
    }
    let enable = Boolean(JSON.parse(enableStatus as string));
    const subLocations =
      await subLocationService.getSubLocationByMainLocationIdAndEnableStatusService(
        mainId,
        enable
      );
    respone(
      res,
      subLocations,
      `Get all subLocation filter by mainLocationId and ebaleStatus is success`,
      200
    );
    loggerInfo(req, controllerName, res.statusCode, "Success");
  } catch (error: any) {
    console.log("Error status:", error.statusCode);
    if (error.statusCode === 500) {
      loggerError(req, controllerName, error.statusCode, error);
    } else {
      loggerWarn(req, controllerName, error.statusCode, error);
    }
    next(error);
  }
}
async function getAllSubLocationController(
  req: Request,
  res: Response,
  next: NextFunction
) {
  let controllerName = getAllSubLocationController.name;
  try {
    console.log("-- get all --");
    const page = req.query.page as string;
    const limit = req.query.limit as string;
    const patternNumFormat = /^-?\d*\.?\d+$/;
    const isStringOfNumberPage = patternNumFormat.test(page);
    const isStringOfNumberLimit = patternNumFormat.test(limit);
    if (page && !isStringOfNumberPage) {
      throw new CustomError(400, "page must be type string of number");
    }
    if (limit && !isStringOfNumberLimit) {
      throw new CustomError(400, "limit must be type string of number");
    }
    let data;
    if (page && limit) {
      data = await subLocationService.getPaginatedAllSubLocationServie(
        +limit,
        +page
      );
      respone(res, data, `Get paginated all subLocation are successfull`, 200);
      return loggerInfo(req, controllerName, 200, "Success");
    } else {
      data = await subLocationService.getAllSubLocationServie();
      respone(res, data, `Get all subLocation are successfull`, 200);
      return loggerInfo(req, controllerName, 200, "Success");
    }
  } catch (error: any) {
    console.log("Error status:", error.statusCode);
    if (error.statusCode === 500) {
      loggerError(req, controllerName, error.statusCode, error);
    } else {
      loggerWarn(req, controllerName, error.statusCode, error);
    }
    next(error);
  }
}
async function deleteSubLocationController(
  req: Request,
  res: Response,
  next: NextFunction
) {
  let controllerName = deleteSubLocationController.name;
  try {
    const { id } = req.params;
    const subLocation = await subLocationService.deleteSubLocationService(id);
    respone(res, subLocation, `1 Sub location deleted successful`, 200);
    loggerInfo(req, controllerName, res.statusCode, "Success");
  } catch (error: any) {
    console.log("Error status:", error.statusCode);
    if (error.statusCode === 500) {
      loggerError(req, controllerName, error.statusCode, error);
    } else {
      loggerWarn(req, controllerName, error.statusCode, error);
    }
    next(error);
  }
}
async function updateSubLocationController(
  req: Request,
  res: Response,
  next: NextFunction
) {
  let controllerName = updateSubLocationController.name;
  try {
    const { id } = req.params;
    const subLocationDto = req.body as UpdateSubLocationDto;
    if (subLocationDto.subLocationName == null) {
      throw new CustomError(400, `subLocationName is required`);
    }
    if (subLocationDto.mainLocationId == null) {
      throw new CustomError(400, `mainLocationId is required`);
    }
    const subLocation = await subLocationService.updateSubLocationService(
      subLocationDto,
      id
    );
    respone(res, subLocation, `Sub location updated successful`, 200);
    loggerInfo(req, controllerName, res.statusCode, "Success");
  } catch (error: any) {
    console.log("Error status:", error.statusCode);
    if (error.statusCode === 500) {
      loggerError(req, controllerName, error.statusCode, error);
    } else {
      loggerWarn(req, controllerName, error.statusCode, error);
    }
    next(error);
  }
}

async function updateEnableStatusOfSubLocationController(
  req: Request,
  res: Response,
  next: NextFunction
) {
  let controllerName = updateEnableStatusOfSubLocationController.name;
  try {
    const { id } = req.params;
    const enableStatus = req.body.enable as boolean;
    const subLocation =
      await subLocationService.updateEnableStatusOfSubLocationService(
        id,
        enableStatus
      );
    respone(res, subLocation, `Sub location updated successful`, 200);
    loggerInfo(req, controllerName, 200, "Success");
  } catch (error: any) {
    console.log("Error status:", error.statusCode);
    if (error.statusCode === 500) {
      loggerError(req, controllerName, error.statusCode, error);
    } else {
      loggerWarn(req, controllerName, error.statusCode, error);
    }
    next(error);
  }
}

export default {
  createSubLocationController,
  deleteSubLocationController,
  getAllSubLocationFilterByMainLocIdController,
  getAllSubLocationFilterByMainLocIdAdnEnableStatusController,
  getAllSubLocationController,
  getSubLocationByIdController,
  updateSubLocationController,
  updateEnableStatusOfSubLocationController,
  // getAllSubLocationByMainLocationIdController,
};

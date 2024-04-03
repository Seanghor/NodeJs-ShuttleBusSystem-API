import { NextFunction, Request, Response } from "express";
import { BusDto } from "../../payload/request/busDto";
import { respone } from "../../payload/respone/defaultRespone";
import busService from "./bus.service";
import { CustomError } from "../../handler/customError";
import {
  loggerError,
  loggerInfo,
  loggerWarn,
} from "../../config/logger/customeLogger";
// create bus
async function createBusController(
  req: Request,
  res: Response,
  next: NextFunction
) {
  const controllerName = createBusController.name;
  try {
    const busDto = req.body as BusDto;
    if (busDto.model == null) {
      throw new CustomError(400, "Model is required");
    }
    if (busDto.plateNumber == null) {
      throw new CustomError(400, "Plate number is required");
    }
    if (busDto.numOfSeat == null) {
      throw new CustomError(400, "Number of seat is required");
    }
    if (busDto.driverName == null) {
      throw new CustomError(400, "Driver name is required");
    }
    if (busDto.driverContact == null) {
      throw new CustomError(400, "Driver contact is required");
    }
    const bus = await busService.createBusService(busDto);
    respone(res, bus, "1 Bus created successful.", 200);
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
// get bus by id
async function getBusByIdController(
  req: Request,
  res: Response,
  next: NextFunction
) {
  const controllerName = getBusByIdController.name;
  try {
    const { id } = req.params;
    const bus = await busService.getBusByIdService(id);
    respone(res, bus, "Get bus by Id is successful.", 200);
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
// get all bus
async function getAllBusController(
  req: Request,
  res: Response,
  next: NextFunction
) {
  const controllerName = getAllBusController.name;
  try {
    const page = req.query.page as string;
    const limit = req.query.limit as string;
    const search = req.query.search as string;
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
      data = await busService.getPaginatedAllBusServie(
        +limit,
        +page,
        search || ""
      );
      respone(res, data, "Get paginated all bus are successful.", 200);
      return loggerInfo(req, controllerName, 200, "Success");
    } else {
      data = await busService.searchBusServie(search || "");
      respone(res, data, "Get all bus are successful.", 200);
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

async function getAllBusFilterByEnableStatusController(
  req: Request,
  res: Response,
  next: NextFunction
) {
  const controllerName = getAllBusFilterByEnableStatusController.name;
  try {
    const enableStatus = req.query.enable as string;
    console.log("-- query enable ---", enableStatus);
    if (enableStatus !== "true" && enableStatus !== "false") {
      throw new CustomError(400, "enable must be type of boolean");
    }
    let enable = Boolean(JSON.parse(enableStatus as string));
    const buses = await busService.getAllFilterByEnableStayusBusServie(enable);
    respone(
      res,
      buses,
      `Get All Buses filter by enableStatus=${enable} is successfull`,
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
// delete bus
async function deleteBusController(
  req: Request,
  res: Response,
  next: NextFunction
) {
  const controllerName = deleteBusController.name;
  try {
    const { id } = req.params;
    const bus = await busService.deleteBusService(id);
    respone(res, bus, "1 bus deleted successful.", 200);
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

async function updateEnableStatusOfBusController(
  req: Request,
  res: Response,
  next: NextFunction
) {
  const controllerName = updateEnableStatusOfBusController.name;
  try {
    const { id } = req.params;
    const enableStatus = req.body.enable as boolean;
    const bus = await busService.updateEnableStatusOfBusService(
      id,
      enableStatus
    );
    respone(res, bus, "update enableStatus of bus is successful.", 200);
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
// update bus
async function updateBusController(
  req: Request,
  res: Response,
  next: NextFunction
) {
  const controllerName = updateBusController.name;
  try {
    const { id } = req.params;
    const busDto = req.body as BusDto;

    if (busDto.model == null) {
      throw new CustomError(400, "Model is required");
    }
    if (busDto.plateNumber == null) {
      throw new CustomError(400, "Plate number is required");
    }
    if (busDto.numOfSeat == null) {
      throw new CustomError(400, "Number of seat is required");
    }
    if (busDto.driverName == null) {
      throw new CustomError(400, "Driver name is required");
    }
    if (busDto.driverContact == null) {
      throw new CustomError(400, "Driver contact is required");
    }
    const busCheck = await busService.getBusByIdService(id);
    if (busCheck == null) {
      throw new CustomError(204, "Bus not found");
    }
    const bus = await busService.updateBusService(id, busDto);
    respone(res, bus, "1 Bus updated successful", 200);
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
  createBusController,
  deleteBusController,
  getAllBusController,
  getAllBusFilterByEnableStatusController,
  getBusByIdController,
  updateBusController,
  updateEnableStatusOfBusController,
};

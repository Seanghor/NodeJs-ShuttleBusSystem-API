import { PrismaClient } from "@prisma/client";
import {
  SubLocationDto,
  UpdateSubLocationDto,
} from "../../payload/request/subLocatonDto";
import { CustomError } from "../../handler/customError";
import { areStringsSameIgnoringSpaces } from "../../util/formatingData";
const prisma = new PrismaClient();

const selectDefault = {
  id: true,
  subLocationName: true,
  enable: true,
  mainLocation: {
    select: {
      id: true,
      mainLocationName: true,
    },
  },
};
async function createSubLocationService(subLocation: SubLocationDto) {
  const listOfSubLoc = await prisma.subLocation.findMany({
    where: {
      mainLocationId: subLocation.mainLocationId,
    },
    select: {
      id: true,
      subLocationName: true,
    },
  });
  const found = listOfSubLoc.find((subLoc) => {
    return areStringsSameIgnoringSpaces(
      subLoc.subLocationName,
      subLocation.subLocationName
    );
  });

  if (found)
    throw new CustomError(
      409,
      "Sub Location name is already exist with duplicate name or similar name"
    );
  const data = await prisma.subLocation.create({
    data: {
      subLocationName: subLocation.subLocationName,
      mainLocationId: subLocation.mainLocationId,
    },
    select: selectDefault,
  });
  return data;
}
async function getAllSubLocationServie() {
  return await prisma.subLocation.findMany({
    select: selectDefault,
    orderBy: {
      createdAt: "desc",
    },
  });
}
async function getPaginatedAllSubLocationServie(limit: number, page: number) {
  const total = await prisma.subLocation.count();
  const pages = Math.ceil(total / limit);
  if (page > pages && pages !== 0)
    throw new CustomError(400, `Sorry, maximum page is ${pages}`);
  const res = await prisma.subLocation.findMany({
    take: limit,
    skip: (page - 1) * limit,
    select: selectDefault,
    orderBy: {
      createdAt: "desc",
    },
  });
  return {
    pagination: {
      totalData: total,
      totalPages: pages,
      dataPerPage: limit,
      currentPage: page,
    },
    data: res,
  };
}
async function getSubLocationByIdService(id: string) {
  return await prisma.subLocation.findUnique({
    where: {
      id: id,
    },
    select: selectDefault,
  });
}
async function deleteSubLocationService(id: string) {
  const check = await prisma.subLocation.findUnique({
    where: {
      id,
    },
  });
  if (!check) throw new CustomError(404, "Sub Location not found");
  const isUsing = await prisma.subLocation.findUnique({
    where: {
      id,
    },
    select: {
      pickupLocation: true,
      dropLocation: true,
    },
  });
  console.log(isUsing);
  if (
    isUsing?.dropLocation &&
    isUsing.dropLocation &&
    isUsing?.pickupLocation.length + isUsing?.dropLocation.length !== 0
  ) {
    throw new CustomError(409, "Cannot delete, sub location is in use now.");
  }

  return await prisma.subLocation.delete({
    where: {
      id: id,
    },
    select: selectDefault,
  });
}

async function updateSubLocationService(
  sublocation: UpdateSubLocationDto,
  id: string
) {
  const listOfSubLoc = await prisma.subLocation.findMany({
    where: {
      mainLocationId: sublocation.mainLocationId,
    },
    select: {
      id: true,
      subLocationName: true,
    },
  });
  const foundDuplicate = listOfSubLoc.find((subLoc) => {
    return areStringsSameIgnoringSpaces(
      subLoc.subLocationName,
      sublocation.subLocationName
    );
  });
  const check = await prisma.subLocation.findUnique({
    where: {
      id,
    },
  });
  if (!check) throw new CustomError(404, "Sub Location not found");

  const checkMailLoc = await prisma.subLocation.findFirst({
    where: {
      mainLocationId: sublocation.mainLocationId,
    },
  });
  if (!checkMailLoc) throw new CustomError(404, "Main Location not found");

  if (foundDuplicate && foundDuplicate.id !== id)
    throw new CustomError(
      409,
      "Sub Location name is already exist with duplicate name or similar name"
    );
  return await prisma.subLocation.update({
    where: {
      id,
    },
    data: {
      subLocationName: sublocation.subLocationName,
      mainLocationId: sublocation.mainLocationId,
    },
    select: selectDefault,
  });
}

async function updateEnableStatusOfSubLocationService(
  id: string,
  status: boolean
) {
  const check = await prisma.subLocation.findUnique({
    where: {
      id,
    },
  });
  if (!check) throw new CustomError(404, "Sub Location not found");
  return await prisma.subLocation.update({
    where: {
      id: id,
    },
    data: {
      enable: status,
    },
    select: selectDefault,
  });
}
async function getSubLocationByMainLocationIdService(id: string) {
  return await prisma.subLocation.findMany({
    where: {
      mainLocationId: id,
    },
    orderBy: {
      createdAt: "asc",
    },
    select: selectDefault,
  });
}

async function getSubLocationByMainLocationIdAndEnableStatusService(
  id: string,
  status: boolean
) {
  return await prisma.subLocation.findMany({
    where: {
      AND: [{ mainLocationId: id }, { enable: status }],
    },
    orderBy: {
      createdAt: "asc",
    },
    select: selectDefault,
  });
}
async function getSubLocationIdByNameService(name: string) {
  const check = await prisma.subLocation.findFirst({
    where: {
      subLocationName: {
        equals: name,
        mode: "insensitive",
      },
    },
  });

  return check;
}

export default {
  createSubLocationService,
  getAllSubLocationServie,
  getPaginatedAllSubLocationServie,
  getSubLocationByIdService,
  deleteSubLocationService,
  updateSubLocationService,
  updateEnableStatusOfSubLocationService,
  getSubLocationByMainLocationIdService,
  getSubLocationByMainLocationIdAndEnableStatusService,
  getSubLocationIdByNameService,
};

import {
  DepartmentEnum,
  GenderEnum,
  PrismaClient,
  RoleEnum,
  User,
} from "@prisma/client";
import {
  asyncronusMail,
  mail,
  mailResetPassword,
  mailSuspendUser,
  mailUnSuspendUser,
} from "../../util/mailSender";
import { comparePassword, encryptPassword } from "../../util/passwordEncrypter";
import jwt from "../../util/jwt-generate";
import { UserDto } from "../../payload/request/userDto";
import { StudentDto } from "../../payload/request/studnetDto";
import { AdminDto } from "../../payload/request/adminDto";
import { StaffDto } from "../../payload/request/staffDto";
import { CustomError } from "../../handler/customError";
import { v4 as uuidv4 } from "uuid";
import pdfService from "../../util/PDFGenerator";
import { getCurrentDateTimeCambodia } from "../../util/formatingData";

const readXlsxFile = require("read-excel-file/node");
const prisma = new PrismaClient();

async function existingUserByEmail(email: string) {
  return await prisma.user.findUnique({
    where: {
      email: email,
    },
  });
}
// done
async function createStudentService(studentDto: StudentDto) {
  // check existing email
  const existingEmail = await existingUserByEmail(studentDto.email);
  if (existingEmail) {
    throw new CustomError(409, "Email already in used");
  }
  // checking batch:
  const existingBatch = await prisma.batch.findUnique({
    where: {
      department_batchNum: {
        department: studentDto.department as DepartmentEnum,
        batchNum: studentDto.batchNum as number,
      },
    },
  });
  if (!existingBatch) {
    throw new CustomError(404, "Department or Batch not found");
  }

  const userData = {
    email: studentDto.email,
    username: studentDto.username,
    password: studentDto.password,
    googlePassword: studentDto.googlePassword || null,
    role: RoleEnum.STUDENT,
    phone: studentDto.phone || null,
    gender: studentDto.gender || null,
    inKRR: (studentDto.inKRR as boolean) || false,
    updatedAt: null,
  } as User;

  // - encrypt passowrd
  userData.password = await encryptPassword(userData.password as string);
  if (userData.googlePassword || userData.googlePassword !== null) {
    userData.googlePassword = await encryptPassword(
      userData.googlePassword as string
    );
  }
  // const User, StudentInfo, Ticket:
  const student = await prisma.user.create({
    data: {
      ...userData,
      ticket: {
        create: {
          updatedAt: null,
        },
      },
      studentInfo: {
        create: {
          batchId: existingBatch.id || null,
        },
      },
    },
  });

  return student;
}
// done
async function createAdminService(adminDto: AdminDto) {
  // check existing email
  const existingEmail = await existingUserByEmail(adminDto.email);
  if (existingEmail) {
    throw new CustomError(409, "Email already in used");
  }
  const userData = {
    email: adminDto.email,
    username: adminDto.username,
    password: adminDto.password,
    googlePassword: adminDto.googlePassword || null,
    role: RoleEnum.ADMIN,
    phone: adminDto.phone || null,
    gender: adminDto.gender || null,
    inKRR: adminDto.inKRR || false,
    updatedAt: null,
  } as User;

  // - encrypt passowrd
  userData.password = await encryptPassword(userData.password as string);
  if (userData.googlePassword || userData.googlePassword !== null) {
    userData.googlePassword = await encryptPassword(
      userData.googlePassword as string
    );
  }

  // create User, AdminInfo:
  const admin = await prisma.user.create({
    data: {
      ...userData,
      adminInfo: {
        create: {},
      },
    },
  });
  return admin;
}
// done
async function createStaffService(staffDto: StaffDto) {
  // check existing email
  const existingEmail = await existingUserByEmail(staffDto.email);
  if (existingEmail) {
    throw new CustomError(409, "Email already in used");
  }

  const userData = {
    email: staffDto.email,
    username: staffDto.username,
    password: staffDto.password,
    googlePassword: staffDto.googlePassword || null,
    role: RoleEnum.STAFF,
    phone: staffDto.phone || null,
    gender: staffDto.gender || null,
    inKRR: staffDto.inKRR || false,
    updatedAt: null,
  } as User;

  // - encrypt passowrd
  userData.password = await encryptPassword(userData.password as string);
  if (userData.googlePassword || userData.googlePassword !== null) {
    userData.googlePassword = await encryptPassword(
      userData.googlePassword as string
    );
  }

  // create User, Ticket, StaffInfo
  const staff = await prisma.user.create({
    data: {
      ...userData,
      ticket: {
        create: {
          updatedAt: null,
        },
      },
      staffInfo: {
        create: {},
      },
    },
  });
  return staff;
}
// done
async function deleteUserService(userId: string) {
  // check id exist or not:
  const existingUser = await prisma.user.findUnique({
    where: {
      id: userId,
    },
  });
  if (!existingUser || existingUser === null) {
    throw new CustomError(204, "User not found");
  }

  // delete user --> Ticket, StudentInfo also delete
  return await prisma.user.delete({
    where: {
      id: userId,
    },
  });
}
// -------------------------------------
async function getAllUserService() {
  return await prisma.user.findMany({
    orderBy: {
      createdAt: "desc",
    },
    select: {
      id: true,
      email: true,
      username: true,
      role: true,
      gender: true,
      inKRR: true,
      password: true,
      phone: true,
      enable: true,
      ticket: {
        select: {
          id: true,
          remainTicket: true,
          ticketLimitInhand: true,
          updatedAt: true,
        },
      },
      studentInfo: {
        select: {
          id: true,
          batch: {
            select: {
              id: true,
              department: true,
              batchNum: true,
            },
          },
        },
      },
      staffInfo: true,
      adminInfo: true,
      superAdminInfo: true,
    },
  });
}
async function getAllUserPaginatedService(
  role: string,
  limit: number,
  page: number,
  status: string,
  search: string
) {
  const total = await prisma.user.count({
    where: {
      AND: [
        { role: role as RoleEnum },
        {
          OR: [
            {
              inKRR:
                status === "inKRR"
                  ? true
                  : status === "notInKRR"
                  ? false
                  : undefined,
            },
            {
              inKRR: {
                not: {
                  equals: undefined, // Ensures both true and false are considered
                },
              },
            },
          ],
        },
        {
          OR: [
            {
              email: {
                contains: search,
                mode: "insensitive",
              },
            },
            {
              username: {
                contains: search,
                mode: "insensitive",
              },
            },
          ],
        },
      ],
    },
  });
  const pages = Math.ceil(total / limit);
  if (page > pages && pages !== 0) {
    throw new CustomError(404, `Sorry maximum page is ${pages}`);
  }
  const res = await prisma.user.findMany({
    where: {
      AND: [
        { role: role as RoleEnum },
        {
          OR: [
            {
              inKRR:
                status === "inKRR"
                  ? true
                  : status === "notInKRR"
                  ? false
                  : undefined,
            },
            {
              inKRR: {
                not: {
                  equals: undefined, // Ensures both true and false are considered
                },
              },
            },
          ],
        },
        {
          OR: [
            {
              email: {
                contains: search,
                mode: "insensitive",
              },
            },
            {
              username: {
                contains: search,
                mode: "insensitive",
              },
            },
          ],
        },
      ],
    },
    take: limit,
    skip: (page - 1) * limit,
    orderBy: {
      createdAt: "desc",
    },
    select: {
      id: true,
      email: true,
      username: true,
      role: true,
      gender: true,
      inKRR: true,
      phone: true,
      enable: true,
      ticket: {
        select: {
          id: true,
          remainTicket: true,
          ticketLimitInhand: true,
          updatedAt: true,
        },
      },
      studentInfo: {
        select: {
          id: true,
          batch: {
            select: {
              id: true,
              department: true,
              batchNum: true,
            },
          },
        },
      },
      staffInfo: true,
      adminInfo: true,
      superAdminInfo: true,
    },
  });
  return {
    pagination: {
      totalData: total,
      totalPage: pages,
      dataPerPage: limit,
      currentPage: page,
    },
    data: res,
  };
}

async function getStudentByDeptAndBatchPaginatedService(
  dept: string,
  batch: string,
  limit: number,
  page: number,
  search: string
) {
  const total = await prisma.user.count({
    where: {
      AND: [
        { role: RoleEnum.STUDENT },
        {
          studentInfo: {
            batch: {
              AND: [
                {
                  OR: [
                    {
                      department: {
                        equals:
                          dept === "all" ? undefined : (dept as DepartmentEnum),
                      },
                    },
                    {
                      department: {
                        not: {
                          equals: dept === "all" ? null : undefined,
                        },
                      },
                    },
                  ],
                },
                {
                  OR: [
                    {
                      batchNum:
                        batch === "all" ? undefined : parseInt(batch, 10),
                    },
                    {
                      batchNum: {
                        not: {
                          equals: batch === "all" ? null : undefined,
                        },
                      },
                    },
                  ],
                },
              ],
            },
          },
        },
        {
          OR: [
            {
              email: {
                contains: search,
                mode: "insensitive",
              },
            },

            {
              username: {
                contains: search,
                mode: "insensitive",
              },
            },
          ],
        },
      ],
    },
  });
  const pages = Math.ceil(total / limit);
  if (page > pages && pages !== 0) {
    throw new CustomError(404, `Sorry maximum page is ${pages}`);
  }

  const res = await prisma.user.findMany({
    where: {
      AND: [
        { role: RoleEnum.STUDENT },
        {
          studentInfo: {
            batch: {
              AND: [
                {
                  OR: [
                    {
                      department: {
                        equals:
                          dept === "all" ? undefined : (dept as DepartmentEnum),
                      },
                    },
                    {
                      department: {
                        not: {
                          equals: dept === "all" ? null : undefined,
                        },
                      },
                    },
                  ],
                },
                {
                  OR: [
                    {
                      batchNum:
                        batch === "all" ? undefined : parseInt(batch, 10),
                    },
                    {
                      batchNum: {
                        not: {
                          equals: batch === "all" ? null : undefined,
                        },
                      },
                    },
                  ],
                },
              ],
            },
          },
        },
        {
          OR: [
            {
              email: {
                contains: search,
                mode: "insensitive",
              },
            },

            {
              username: {
                contains: search,
                mode: "insensitive",
              },
            },
          ],
        },
      ],
    },
    take: limit,
    skip: (page - 1) * limit,
    orderBy: {
      createdAt: "desc",
    },
    select: {
      id: true,
      email: true,
      username: true,
      role: true,
      gender: true,
      inKRR: true,
      phone: true,
      enable: true,
      ticket: {
        select: {
          id: true,
          remainTicket: true,
          ticketLimitInhand: true,
          updatedAt: true,
        },
      },
      studentInfo: {
        select: {
          id: true,
          batch: {
            select: {
              id: true,
              department: true,
              batchNum: true,
            },
          },
        },
      },
    },
  });
  return {
    pagination: {
      totalData: total,
      totalPage: pages,
      dataPerPage: limit,
      currentPage: page,
    },
    data: res,
  };
}
async function getStudetByDeptAndBatchService(
  dept: string,
  batch: string,
  search: string
) {
  return await prisma.user.findMany({
    where: {
      AND: [
        { role: RoleEnum.STUDENT },
        {
          studentInfo: {
            batch: {
              AND: [
                {
                  OR: [
                    {
                      department: {
                        equals:
                          dept === "all" ? undefined : (dept as DepartmentEnum),
                      },
                    },
                    {
                      department: {
                        not: {
                          equals: dept === "all" ? null : undefined,
                        },
                      },
                    },
                  ],
                },
                {
                  OR: [
                    {
                      batchNum:
                        batch === "all" ? undefined : parseInt(batch, 10),
                    },
                    {
                      batchNum: {
                        not: {
                          equals: batch === "all" ? null : undefined,
                        },
                      },
                    },
                  ],
                },
              ],
            },
          },
        },
        {
          OR: [
            {
              email: {
                contains: search,
                mode: "insensitive",
              },
            },
            {
              username: {
                contains: search,
                mode: "insensitive",
              },
            },
          ],
        },
      ],
    },
    orderBy: {
      createdAt: "desc",
    },
    select: {
      id: true,
      email: true,
      username: true,
      role: true,
      gender: true,
      inKRR: true,
      phone: true,
      enable: true,
      ticket: {
        select: {
          id: true,
          remainTicket: true,
          ticketLimitInhand: true,
          updatedAt: true,
        },
      },
      studentInfo: {
        select: {
          id: true,
          batch: {
            select: {
              id: true,
              department: true,
              batchNum: true,
            },
          },
        },
      },
    },
  });
}
// done
async function getUserByIdService(userId: string) {
  const user = await prisma.user.findUnique({
    where: {
      id: userId,
    },
    select: {
      id: true,
      email: true,
      username: true,
      role: true,
      gender: true,
      inKRR: true,
      phone: true,
      ticket: {
        select: {
          id: true,
          remainTicket: true,
          ticketLimitInhand: true,
          updatedAt: true,
        },
      },
      studentInfo: {
        select: {
          id: true,
          batch: {
            select: {
              id: true,
              department: true,
              batchNum: true,
            },
          },
        },
      },
      staffInfo: true,
      adminInfo: true,
      superAdminInfo: true,
    },
  });
  if (!user || user === null) {
    throw new CustomError(404, "User not found");
  }
  return user;
}
// done
async function updateStudentByUserId(
  userId: string,
  newStudentDto: StudentDto
) {
  // check email:
  const existingEmail = await existingUserByEmail(newStudentDto.email);
  const user = await prisma.user.findUnique({
    where: {
      id: userId,
    },
  });

  // if email input is exist in database && email that existed is not belong to user that we want to update
  // in short: if we didn't update email and keep it same as before
  if (existingEmail && user?.email !== newStudentDto.email) {
    throw new CustomError(409, "Eamil already existed");
  }

  // check department:
  const existingDepartmentAndBatch = await prisma.batch.findUnique({
    where: {
      department_batchNum: {
        department: newStudentDto.department as DepartmentEnum,
        batchNum: newStudentDto.batchNum as number,
      },
    },
  });
  if (!existingDepartmentAndBatch || existingDepartmentAndBatch === null) {
    throw new CustomError(204, "Department with batch is not existed");
  }

  const newUserData = {
    email: newStudentDto.email,
    username: newStudentDto.username,
    password:
      newStudentDto.password === null
        ? user?.password
        : await encryptPassword(newStudentDto.password as string),
    googlePassword:
      newStudentDto.googlePassword === null && user?.googlePassword == null
        ? null
        : newStudentDto.googlePassword != null
        ? await encryptPassword(newStudentDto.googlePassword as string)
        : user?.googlePassword,
    phone: newStudentDto.phone ?? "",
    gender: newStudentDto.gender ?? GenderEnum.MALE,
    inKRR: newStudentDto.inKRR ?? false,
    role: newStudentDto.role ?? RoleEnum.STUDENT,
  } as User;
  console.log(newUserData);

  // update: User, StudentInfo
  const newUser = await prisma.user.update({
    where: {
      id: userId,
    },
    data: {
      ...newUserData,
      studentInfo: {
        update: {
          batchId: existingDepartmentAndBatch.id || null,
        },
      },
    },
  });
  return newUser;
}
// done
async function updateStaffByUserId(userId: string, newStafftDto: StaffDto) {
  // check email:
  const existingEmail = await existingUserByEmail(newStafftDto.email);
  const user = await prisma.user.findUnique({
    where: {
      id: userId,
    },
  });

  // if email input is exist in database && email that existed is not belong to user that we want to update
  // in short: if we didn't update email and keep it same as before
  if (existingEmail && user?.email !== newStafftDto.email) {
    throw new CustomError(409, "Eamil already existed");
  }

  const newUserData = {
    email: newStafftDto.email,
    username: newStafftDto.username,
    password:
      newStafftDto.password == null
        ? user?.password
        : await encryptPassword(newStafftDto.password as string),
    googlePassword:
      newStafftDto.googlePassword == null && user?.googlePassword == null
        ? null
        : newStafftDto.googlePassword != null
        ? await encryptPassword(newStafftDto.googlePassword as string)
        : user?.googlePassword,
    phone: newStafftDto.phone || null,
    gender: newStafftDto.gender || null,
    inKRR: newStafftDto.inKRR || null,
    role: newStafftDto.role || null,
  } as User;

  // update: User, StudentInfo
  const newUser = await prisma.user.update({
    where: {
      id: userId,
    },
    data: newUserData,
  });
  return newUser;
}

// done
async function updateAdminByUserId(userId: string, newAdminDto: AdminDto) {
  // check email:
  const existingEmail = await existingUserByEmail(newAdminDto.email);
  const user = await prisma.user.findUnique({
    where: {
      id: userId,
    },
  });

  // if email input is exist in database && email that existed is not belong to user that we want to update
  // in short: if we didn't update email and keep it same as before
  if (existingEmail && user?.email !== newAdminDto.email) {
    throw new CustomError(409, "Eamil already existed");
  }

  const newUserData = {
    email: newAdminDto.email,
    username: newAdminDto.username,
    password:
      newAdminDto.password === null
        ? user?.password
        : await encryptPassword(newAdminDto.password as string),
    googlePassword:
      newAdminDto.googlePassword == null && user?.googlePassword == null
        ? null
        : newAdminDto.googlePassword != null
        ? await encryptPassword(newAdminDto.googlePassword as string)
        : user?.googlePassword,
    phone: newAdminDto.phone || null,
    gender: newAdminDto.gender || null,
    inKRR: newAdminDto.inKRR || null,
  } as User;

  // update: User, StudentInfo
  const newUser = await prisma.user.update({
    where: {
      id: userId,
    },
    data: newUserData,
  });
  return newUser;
}

async function changePasswordService(
  userId: string,
  oldPassword: string,
  newPassword: string
) {
  const check = await prisma.user.findUnique({
    where: {
      id: userId,
    },
  });

  if (!check) {
    throw new CustomError(404, "User not found");
  }
  const checkPassword = comparePassword(oldPassword, check.password || "");
  if (!checkPassword) {
    throw new CustomError(401, "Wrong password");
  }

  const user = await prisma.user.update({
    where: {
      id: userId,
    },
    data: {
      password: await encryptPassword(newPassword),
    },
  });
  return user;
}
async function loginService(email: string, password: string) {
  const user = await prisma.user.findUnique({
    where: {
      email: email,
    },
    select: {
      id: true,
      username: true,
      email: true,
      password: true,
      role: true,
      enable: true,
    },
  });
  if (!user) {
    throw new CustomError(401, "Invalid credentials");
  }
  if (user.role === RoleEnum.ADMIN) {
    throw new CustomError(401, "Admin is not user");
  }
  if (!user.enable) {
    throw new CustomError(401, "User is disabled");
  }
  const checkPassword = await comparePassword(password, user.password || "");
  if (!checkPassword) {
    throw new CustomError(401, "Wrong password");
  }
  const token = jwt.jwtGenerator(user as User);
  return token;
}
async function registerService(userDto: UserDto) {
  const gender =
    userDto.gender.toUpperCase() == "MALE"
      ? GenderEnum.MALE
      : GenderEnum.FEMALE;
  const user = await prisma.user.create({
    data: {
      username: userDto.username,
      email: userDto.email,
      password: userDto.password,
      role: RoleEnum.CUSTOMER,
      enable: true,
      phone: userDto.phone,
      gender: gender,
    },
  });
  return user;
}
async function getUserByEmailService(email: string) {
  const user = await prisma.user.findUnique({
    where: {
      email: email,
    },
    select: {
      id: true,
      username: true,
      email: true,
      password: true,
      role: true,
      enable: true,
    },
  });
  return user;
}

async function requestResetPasswordService(email: string) {
  const user = await prisma.user.findUnique({
    where: {
      email: email,
    },
    select: {
      id: true,
      username: true,
      email: true,
      password: true,
      role: true,
      enable: true,
    },
  });
  if (!user) {
    throw new CustomError(404, "User not found");
  }
  await mailResetPassword(email, user.username || "");
  return null;
}
async function confirmResetPasswordWithTokenService(
  pass: string,
  email: string
) {
  const checkUser = await prisma.user.findUnique({
    where: {
      email: email,
    },
  });
  if (!checkUser) {
    throw new CustomError(404, "User not found");
  }
  const user = await prisma.user.update({
    where: {
      email: email,
    },
    data: {
      password: await encryptPassword(pass),
    },
  });
}
async function handleEnableAllUserByRoleService(
  role: RoleEnum,
  enableStatus: boolean
) {
  const listUsers = await prisma.user.findMany({
    where: {
      AND: [{ role }, { enable: !enableStatus }],
    },
  });

  for (let user of listUsers) {
    await prisma.user.update({
      where: {
        id: user.id,
      },
      data: {
        enable: enableStatus,
      },
    });

    // handle mail
    // if (enableStatus) {
    //   await mailUnSuspendUser(user.email || "", user.username || "");
    // } else if (!enableStatus) {
    //   await mailUnSuspendUser(user.email || "", user.username || "");
    // }
  }
  const mappedUsers = listUsers.map((singleUser) => ({
    username: singleUser.username,
    email: singleUser.email,
  }));

  return mappedUsers;
}

// done
async function handleEnableStudentOfDepartmentAndBatchByBatchIdService(
  role: RoleEnum,
  batchId: string,
  enableStatus: boolean
) {
  const check = await prisma.user.findMany({
    where: {
      AND: [
        { role: role },
        { studentInfo: { batchId: batchId } },
        { enable: !enableStatus },
      ],
    },
  });

  const listStudents = await prisma.user.findMany({
    where: {
      AND: [{ role }, { studentInfo: { batchId } }, { enable: !enableStatus }],
    },
  });

  for (let student of listStudents) {
    await prisma.user.update({
      where: {
        id: student.id,
      },
      data: {
        enable: enableStatus,
      },
    });

    const email = student.email || "";
    const username = student.username || "";

    // send mail
    if (enableStatus) {
      mailUnSuspendUser(email, username).catch((error) => {
        console.error("Error sending unsuspend email:", error);
      });
      // await mailUnSuspendUser(student.email || "", student.username || "");
    } else if (!enableStatus) {
      mailSuspendUser(email, username).catch((error) => {
        console.error("Error sending suspend email:", error);
      });
      // await mailUnSuspendUser(student.email || "", student.username || "");
    }
  }
  const mappedUsers = listStudents.map((student) => ({
    username: student.username,
    email: student.email,
  }));
  return mappedUsers;
}

async function viewUserBookingHistoryService(userId: string) {
  return await prisma.user.findMany({
    where: {
      id: userId,
      booking: {
        every: {
          status: "USED",
        },
      },
    },
    select: {
      id: true,
      createdAt: true,
      booking: {
        select: {
          id: true,
          createdAt: true,
          status: true,
          updatedAt: true,
          payStatus: true,
          schedule: {
            select: {
              id: true,
              date: true,
              bus: {
                select: {
                  id: true,
                  driverName: true,
                  plateNumber: true,
                  model: true,
                  numOfSeat: true,
                  driverContact: true,
                },
              },
              availableSeat: true,
              departure: {
                select: {
                  id: true,
                  departureTime: true,
                  destination: {
                    select: {
                      id: true,
                      mainLocationName: true,
                    },
                  },
                  from: {
                    select: {
                      id: true,
                      mainLocationName: true,
                    },
                  },
                  dropLocation: {
                    select: {
                      subLocationName: true,
                    },
                  },
                  pickupLocation: {
                    select: {
                      subLocationName: true,
                    },
                  },
                },
              },
            },
          },
        },
      },
    },
  });
}
async function importUserService(file: any) {
  var listUser: User[] = [];
  await readXlsxFile(Buffer.from(file.buffer)).then(async (data: any) => {
    for (let i = 1; i < data.length; i++) {
      const userRole = data[i][4];

      //check if user already exist
      const checkUser = await prisma.user.findUnique({
        where: {
          email: data[i][3],
        },
      });
      if (checkUser) {
        throw new CustomError(401, "User already exist");
      }
      if (userRole === RoleEnum.STUDENT) {
        var checkBatch = await prisma.batch.findUnique({
          where: {
            department_batchNum: {
              department: data[i][8],
              batchNum: data[i][7],
            },
          },
        });
        if (checkBatch == null) {
          checkBatch = await prisma.batch.create({
            data: {
              department: data[i][8],
              batchNum: data[i][7],
            },
          });
        }
        const enPwd = await encryptPassword(data[i][2].toString());

        // encrypt password before add into database
        const user = await prisma.user.create({
          data: {
            username: data[i][1],
            gender: data[i][5],
            phone: `${data[i][6]}`,
            email: data[i][3],
            password: `${enPwd}`,
            role: userRole,
            updatedAt: null,
            studentInfo: {
              create: {
                batchId: checkBatch.id,
              },
            },
            ticket: {
              create: {},
            },
          },
        });
        const mailSend = await mail(data[i][3], data[i][1], data[i][2]).catch(
          (err) => console.log(err)
        );
        console.log(data[i][3] + " send mail done .!");
        listUser.push(user);
      } else if (userRole === RoleEnum.STAFF) {
        const staff = await prisma.user.create({
          data: {
            username: data[i][1],
            gender: data[i][5],
            phone: `${data[i][6]}`,
            email: data[i][3],
            password: `${data[i][2]}`,
            role: userRole,
            updatedAt: null,
            staffInfo: {
              create: {},
            },
            ticket: {
              create: {},
            },
          },
        });
        const mailSend = await mail(data[i][3], data[i][1], data[i][2]);
        console.log(data[i][3] + " send mail done .!");
        listUser.push(staff);
      } else if (userRole === RoleEnum.ADMIN) {
        const admin = await prisma.user.create({
          data: {
            username: data[i][1],
            gender: data[i][5],
            phone: `${data[i][6]}`,
            email: data[i][3],
            password: `${data[i][2]}`,
            role: userRole,
            updatedAt: null,
            adminInfo: {
              create: {},
            },
            ticket: {
              create: {},
            },
          },
        });
        const mailSend = await mail(data[i][3], data[i][1], data[i][2]);
        console.log(data[i][3] + " send mail done .!");
        listUser.push(admin);
      } else if (userRole === RoleEnum.CUSTOMER) {
        // implement in next phase
      }
    }
  });
  return listUser;
}
async function loginAdminService(email: string, password: string) {
  const user = await prisma.user.findUnique({
    where: {
      email: email,
    },
    select: {
      id: true,
      username: true,
      email: true,
      password: true,
      role: true,
      enable: true,
    },
  });
  if (!user) {
    throw new CustomError(
      401,
      `Invalid email. Please check the email address you entered and try again.`
    );
  }
  if (user.role !== RoleEnum.ADMIN && user.role !== RoleEnum.SUPERADMIN) {
    throw new CustomError(401, "Admin side cannot login with User credentail.");
  }
  if (!user.enable) {
    throw new CustomError(401, "Your account has been suspended.");
  }
  console.log("Password Zin:", user.password);
  console.log("Password Input:", password);

  const checkPassword = await comparePassword(password, user.password || "");

  if (!checkPassword) {
    throw new CustomError(
      401,
      "Wrong password. Please check the password you entered and try again."
    );
  }
  const token = jwt.jwtGenerator(user as User);
  return token;
}
async function requestResetPasswordAdminService(email: string) {
  const checkUser = await prisma.user.findUnique({
    where: {
      email: email,
    },
  });
  if (!checkUser) {
    throw new CustomError(404, "User not found");
  }

  if (checkUser!.role != "ADMIN" && checkUser!.role != "SUPERADMIN") {
    throw new CustomError(409, "You do have permission to access.");
  } else {
    const mailSend = await mailResetPassword(email, checkUser.username || "");
    return mailSend;
  }
}

async function loginVKclub(email: string) {
  const existingUser = await prisma.user.findUnique({
    where: {
      email: email,
    },
  });
  if (existingUser) {
    return jwt.jwtGenerator(existingUser as User);
  } else {
    throw new CustomError(404, "User not found in SBS");
  }
}

function generateRandomPassword(): string {
  const uuid = uuidv4();
  const password = uuid.split("-")[0];
  return password;
}
async function exportUsers() {
  const data = [];
  let index = 1;
  const currentDate = new Date();
  const year = currentDate.getFullYear();
  const month = currentDate.getMonth() + 1; // Months are zero-indexed
  const day = currentDate.getDate();
  const listUsers = await prisma.user.findMany({
    where: {
      role: {
        notIn: ["ADMIN", "SUPERADMIN"],
      },
    },
    orderBy: [{ role: "asc" }, { inKRR: "asc" }],
    include: {
      studentInfo: {
        select: {
          batch: true,
        },
      },
    },
  });

  for (let user of listUsers) {
    data.push({
      index: index,
      date: `${day}-${month}-${year}`,
      username: user.username || "---:---",
      status: user.inKRR ? "In KRR" : "Not In KRR",
      role: String(user.role?.toLocaleLowerCase()),
      gender: user.gender
        ? String(user.gender?.toLocaleLowerCase())
        : "---:---",
      department:
        user.studentInfo?.batch?.department === "SOFTWAREENGINEERING"
          ? `SE-B${user.studentInfo?.batch?.batchNum}`
          : user.studentInfo?.batch?.department === "TOURISMANDMANAGEMENT"
          ? `TM-B${user.studentInfo?.batch?.batchNum}`
          : user.studentInfo?.batch?.department === "ARCHITECTURE"
          ? `AC-B${user.studentInfo?.batch?.batchNum}`
          : "---:---",
      email: user.email || "---:---",
      phone: user.phone || "---:---",
    });
    index++;
  }
  const createAt = getCurrentDateTimeCambodia();

  // res
  const pdfBuffer = await pdfService.downloadToPDF(data, "All-User", createAt);
  return pdfBuffer;
}

async function exportUserByStatus(status: boolean) {
  const data = [];
  let index = 1;
  const listUsers = await prisma.user.findMany({
    where: {
      inKRR: status,
      role: {
        notIn: ["ADMIN", "SUPERADMIN"],
      },
    },
    orderBy: [{ role: "asc" }, { inKRR: "asc" }],
    include: {
      studentInfo: {
        select: {
          batch: true,
        },
      },
    },
  });

  for (let user of listUsers) {
    let shortCurt_gender =
      user.gender === "MALE" ? "M" : user.gender === "FEMALE" ? "F" : "---:---";
    data.push({
      index: index,
      username: user.username || "---:---",
      email: user.email || "---:---",
      status: user.inKRR ? "In KRR" : "Not In KRR",
      role: String(user.role?.toLocaleLowerCase()),
      gender: shortCurt_gender,
      department:
        user.studentInfo?.batch?.department === "SOFTWAREENGINEERING"
          ? `SE-B${user.studentInfo?.batch?.batchNum}`
          : user.studentInfo?.batch?.department === "TOURISMANDMANAGEMENT"
          ? `TM-B${user.studentInfo?.batch?.batchNum}`
          : user.studentInfo?.batch?.department === "ARCHITECTURE"
          ? `AC-B${user.studentInfo?.batch?.batchNum}`
          : "KIT/GUEST",
      phone: user.phone || "---:---",
    });
    index++;
  }

  // res
  const status_inkrr = status ? "In KRR" : "Not In KRR";
  const listname = `All-User ${status_inkrr}`;
  const createAt = getCurrentDateTimeCambodia();
  const stringBuffer = await pdfService.downloadToPDF(data, listname, createAt);
  return stringBuffer;
}

async function exportUserByRoleAndStatus(role: RoleEnum, status: boolean) {
  const data = [];
  let index = 1;
  const listUsers = await prisma.user.findMany({
    where: {
      AND: [{ inKRR: status }, { role: role }],
    },
    orderBy: [{ role: "asc" }, { inKRR: "asc" }],
    include: {
      studentInfo: {
        select: {
          batch: true,
        },
      },
    },
  });

  for (let user of listUsers) {
    data.push({
      index: index,
      username: user.username || "---:---",
      status: user.inKRR ? "In KRR" : "Not In KRR",
      role: String(user.role?.toLocaleLowerCase()),
      gender:
        user.gender === "FEMALE"
          ? "F"
          : user.gender === "MALE"
          ? "M"
          : "---:---",
      department:
        user.role === "STUDENT" && user.studentInfo?.batch?.department
          ? user.studentInfo?.batch?.department === "SOFTWAREENGINEERING"
            ? `SE-B${user.studentInfo?.batch?.batchNum}`
            : user.studentInfo?.batch?.department === "TOURISMANDMANAGEMENT"
            ? `TM-B${user.studentInfo?.batch?.batchNum}`
            : user.studentInfo?.batch?.department === "ARCHITECTURE"
            ? `AC-B${user.studentInfo?.batch?.batchNum}`
            : "---:---"
          : user.role === "STAFF"
          ? "KIT-Staff"
          : "KIT/GUEST",
      email: user.email || "---:---",
      phone: user.phone || "---:---",
    });
    index++;
  }

  // res
  const status_inkrr = status ? "In KRR" : "Not In KRR";
  const sheetName = `All-${
    role.charAt(0).toUpperCase() + role.slice(1).toLowerCase()
  } ${status_inkrr}`;

  const createAt = getCurrentDateTimeCambodia();
  let res;
  if (role === "STUDENT") {
    res = await pdfService.downloadStudentToPDF(data, sheetName, createAt);
  } else if (role === "STAFF") {
    res = await pdfService.downloadStaffToPDF(data, sheetName, createAt);
  }
  return res;
}

async function exportStudentByDepartment(
  role: RoleEnum,
  department: DepartmentEnum
) {
  const data = [];
  let index = 1;

  const listUsers = await prisma.user.findMany({
    where: {
      AND: [
        { role: role },
        {
          studentInfo: {
            batch: {
              department: department,
            },
          },
        },
      ],
    },
    orderBy: [{ role: "asc" }, { inKRR: "asc" }],
    include: {
      studentInfo: {
        select: {
          batch: true,
        },
      },
    },
  });

  for (let user of listUsers) {
    data.push({
      index: index,
      username: user.username || "---:---",
      status: user.inKRR ? "In KRR" : "Not In KRR",
      role: String(user.role?.toLocaleLowerCase()),
      gender:
        user.gender === "FEMALE"
          ? "F"
          : user.gender === "MALE"
          ? "M"
          : "---:---",
      department:
        user.studentInfo?.batch?.department === "SOFTWAREENGINEERING"
          ? `SE-B${user.studentInfo?.batch?.batchNum}`
          : user.studentInfo?.batch?.department === "TOURISMANDMANAGEMENT"
          ? `TM-B${user.studentInfo?.batch?.batchNum}`
          : user.studentInfo?.batch?.department === "ARCHITECTURE"
          ? `AC-B${user.studentInfo?.batch?.batchNum}`
          : "---:---",
      email: user.email || "---:---",
      phone: user.phone || "---:---",
    });
    index++;
  }

  // res
  const dept =
    department === "SOFTWAREENGINEERING"
      ? "DSE"
      : department === "TOURISMANDMANAGEMENT"
      ? "DTM"
      : department === "ARCHITECTURE"
      ? "DAC"
      : "N/A";
  const sheetName = `Student - ${dept}`;
  const createAt = getCurrentDateTimeCambodia();

  const res = await pdfService.downloadStudentToPDF(data, sheetName, createAt);
  return res;
}

async function exportStudentByDepartmentAndbatch(
  role: RoleEnum,
  department: DepartmentEnum,
  batch: number
) {
  const data = [];
  let index = 1;
  const listUsers = await prisma.user.findMany({
    where: {
      AND: [
        { role: role },
        {
          studentInfo: {
            batch: {
              department: department,
              batchNum: batch,
            },
          },
        },
      ],
    },
    orderBy: [{ role: "asc" }, { inKRR: "asc" }],
    include: {
      studentInfo: {
        select: {
          batch: true,
        },
      },
    },
  });

  for (let user of listUsers) {
    data.push({
      index: index,
      username: user.username || "---:---",
      status: user.inKRR ? "In KRR" : "Out KRR",
      role: String(user.role?.toLocaleLowerCase()),
      gender:
        user.gender === "FEMALE"
          ? "F"
          : user.gender === "MALE"
          ? "M"
          : "---:---",
      department:
        user.studentInfo?.batch?.department === "SOFTWAREENGINEERING"
          ? `SE-B${user.studentInfo?.batch?.batchNum}`
          : user.studentInfo?.batch?.department === "TOURISMANDMANAGEMENT"
          ? `TM-B${user.studentInfo?.batch?.batchNum}`
          : user.studentInfo?.batch?.department === "ARCHITECTURE"
          ? `AC-B${user.studentInfo?.batch?.batchNum}`
          : "---:---",
      email: user.email || "---:---",
      phone: user.phone || "---:---",
    });
    index++;
  }

  // res
  const dept =
    department === "SOFTWAREENGINEERING"
      ? "DSE"
      : department === "TOURISMANDMANAGEMENT"
      ? "DTM"
      : department === "ARCHITECTURE"
      ? "DAC"
      : "N/A";
  const sheetName = `Student ${dept}-B${batch}`;
  const createAt = getCurrentDateTimeCambodia();
  const res = await pdfService.downloadStudentToPDF(data, sheetName, createAt);
  return res;
}

async function exportStudentOfDepartmentBatchByStatus(
  role: RoleEnum,
  department: DepartmentEnum,
  batch: number,
  status: boolean
) {
  const data = [];
  let index = 1;

  const listUsers = await prisma.user.findMany({
    where: {
      AND: [
        { role: role },
        { inKRR: status },
        {
          studentInfo: {
            batch: {
              department: department,
              batchNum: batch,
            },
          },
        },
      ],
    },
    orderBy: [{ role: "asc" }, { inKRR: "asc" }],
    include: {
      studentInfo: {
        select: {
          batch: true,
        },
      },
    },
  });

  for (let user of listUsers) {
    data.push({
      index: index,
      username: user.username || "---:---",
      status: user.inKRR ? "In KRR" : "Not In KRR",
      role: String(user.role?.toLocaleLowerCase()),
      gender: user.gender
        ? String(user.gender?.toLocaleLowerCase())
        : "---:---",
      department:
        user.studentInfo?.batch?.department === "SOFTWAREENGINEERING"
          ? `SE-B${user.studentInfo?.batch?.batchNum}`
          : user.studentInfo?.batch?.department === "TOURISMANDMANAGEMENT"
          ? `TM-B${user.studentInfo?.batch?.batchNum}`
          : user.studentInfo?.batch?.department === "ARCHITECTURE"
          ? `AC-B${user.studentInfo?.batch?.batchNum}`
          : "---:---",
      email: user.email || "---:---",
      phone: user.phone || "---:---",
    });
    index++;
  }

  // res
  const status_inkrr = status ? "In KRR" : "Out KRR";
  const dept =
    department === "SOFTWAREENGINEERING"
      ? "DSE"
      : department === "TOURISMANDMANAGEMENT"
      ? "DTM"
      : department === "ARCHITECTURE"
      ? "DAC"
      : "N/A";
  const sheetName = `Student ${dept}-B${batch} ${status_inkrr}`;
  const createAt = getCurrentDateTimeCambodia();

  const res = await pdfService.downloadStudentToPDF(data, sheetName, createAt);
  return res;
}

async function exportUserByRole(role: RoleEnum) {
  const data = [];
  let index = 1;
  const listUsers = await prisma.user.findMany({
    where: {
      role: role as RoleEnum,
    },
    include: {
      studentInfo: {
        select: {
          batch: true,
        },
      },
    },
  });

  for (let user of listUsers) {
    data.push({
      index: index,
      // date: `${day}-${month}-${year}`,
      username: user.username || "---:---",
      status: user.inKRR ? "In KRR" : "Not In KRR",
      role: String(user.role?.toLocaleLowerCase()),
      gender:
        user.gender === "FEMALE"
          ? "F"
          : user.gender === "MALE"
          ? "M"
          : "---:---",
      department:
        user.role === "STUDENT" && user.studentInfo?.batch?.department
          ? user.studentInfo?.batch?.department === "SOFTWAREENGINEERING"
            ? `SE-B${user.studentInfo?.batch?.batchNum}`
            : user.studentInfo?.batch?.department === "TOURISMANDMANAGEMENT"
            ? `TM-B${user.studentInfo?.batch?.batchNum}`
            : user.studentInfo?.batch?.department === "ARCHITECTURE"
            ? `AC-B${user.studentInfo?.batch?.batchNum}`
            : "---:---"
          : user.role === "STAFF"
          ? "KIT-Staff"
          : "KIT/GUEST",
      email: user.email || "---:---",
      phone: user.phone || "---:---",
    });
    index++;
  }

  const sheetName = `All-${
    role.charAt(0).toUpperCase() + role.slice(1).toLowerCase()
  }`;
  // res
  const createAt = getCurrentDateTimeCambodia();
  let res;
  if (role === "STUDENT") {
    res = await pdfService.downloadStudentToPDF(data, sheetName, createAt);
  } else if (role === "STAFF") {
    res = await pdfService.downloadStaffToPDF(data, sheetName, createAt);
  }
  // else {
  //   // res = await excelService.downloadExcel(data, role);
  // }

  return res;
}

async function handleEnableStudentByBatch(
  department: DepartmentEnum,
  batch: number,
  status: boolean
) {
  const listUsersUpdate = await prisma.user.findMany({
    where: {
      AND: [
        { role: RoleEnum.STUDENT },
        { enable: !status },
        {
          studentInfo: {
            batch: {
              AND: [{ department }, { batchNum: batch }],
            },
          },
        },
      ],
    },
  });

  for (let student of listUsersUpdate) {
    await prisma.user.update({
      where: {
        id: student.id,
      },
      data: {
        enable: status,
      },
    });

    const email = student.email || "";
    const username = student.username || "";

    // handle send mail:
    if (status) {
      // await mailUnSuspendUser(student?.email || "", student.username || "");
      mailUnSuspendUser(email, username).catch((error) => {
        console.error("Error sending unsuspend email:", error);
      });
    } else if (!status) {
      // await mailSuspendUser(student?.email || "", student.username || "");
      mailSuspendUser(email, username).catch((error) => {
        console.error("Error sending suspend email:", error);
      });
    }
  }

  const mappedUsers = listUsersUpdate.map((student) => ({
    username: student.username,
    email: student.email,
  }));

  return mappedUsers;
}

async function handleEnableStaffAndStudetByUserId(
  userId: string,
  status: boolean
) {
  const user = await prisma.user.findFirst({
    where: {
      AND: [
        {
          OR: [{ role: RoleEnum.STUDENT }, { role: RoleEnum.STAFF }],
        },
        {
          id: userId,
        },
      ],
    },
  });
  if (!user) {
    throw new CustomError(404, "User not found");
  }

  if (status == user.enable) {
    throw new CustomError(409, `User already ${status ? "enable" : "disable"}`);
  }

  // Start email sending process without awaiting its completion
  const email = user.email || "";
  const username = user.username || "";

  if (status) {
    mailUnSuspendUser(email, username).catch((error) => {
      console.error("Error sending unsuspend email:", error);
    });
  } else {
    mailSuspendUser(email, username).catch((error) => {
      console.error("Error sending suspend email:", error);
    });
  }
  return await prisma.user.update({
    where: {
      id: user?.id || "",
    },
    data: {
      enable: status,
    },
  });

  // console.log("---->", user);
}

async function handleEnableAdminByUserId(userId: string, status: boolean) {
  const user = await prisma.user.findFirst({
    where: {
      AND: [
        { role: RoleEnum.ADMIN },
        {
          id: userId,
        },
      ],
    },
  });
  if (!user) {
    throw new CustomError(404, "User not found");
  }

  if (status == user.enable) {
    throw new CustomError(409, `User already ${status ? "enable" : "disable"}`);
  }

  const email = user.email || "";
  const username = user.username || "";

  if (status) {
    // await mailUnSuspendUser(user.email || "", user.username || "");
    mailUnSuspendUser(email, username).catch((error) => {
      console.error("Error sending unsuspend email:", error);
    });
  } else if (!status) {
    // await mailSuspendUser(user.email || "", user.username || "");
    mailSuspendUser(email, username).catch((error) => {
      console.error("Error sending suspend email:", error);
    });
  }
  return await prisma.user.update({
    where: {
      id: user?.id || "",
    },
    data: {
      enable: status,
    },
  });

  // console.log("---->", user);
}

async function sendWishingMail(department: DepartmentEnum, bacth: number) {
  console.log("dept", department);
  console.log("batch", bacth);

  const listUsers = await prisma.user.findMany({
    where: {
      AND: [
        { role: RoleEnum.STUDENT },
        {
          studentInfo: {
            batch: {
              AND: [{ department }, { batchNum: bacth }],
            },
          },
        },
      ],
    },
  });

  const mappedUsers = listUsers.map((user) => ({
    username: user.username,
    email: user.email,
  }));
  for (let user of listUsers) {
    await asyncronusMail(user.email || "", user.username || "");
  }
  return mappedUsers;
}

export default {
  exportUsers,
  exportUserByStatus,
  exportUserByRole,
  exportStudentByDepartment,
  exportUserByRoleAndStatus,
  exportStudentOfDepartmentBatchByStatus,
  exportStudentByDepartmentAndbatch,
  getAllUserService,
  getAllUserPaginatedService,
  getUserByEmailService,
  getUserByIdService,

  getStudentByDeptAndBatchPaginatedService,
  getStudetByDeptAndBatchService,

  createStudentService,
  createAdminService,
  createStaffService,
  updateStudentByUserId,
  updateStaffByUserId,
  updateAdminByUserId,
  deleteUserService,
  confirmResetPasswordWithTokenService,
  registerService,
  loginService,
  changePasswordService,
  viewUserBookingHistoryService,
  importUserService,
  requestResetPasswordService,
  loginAdminService,
  requestResetPasswordAdminService,
  loginVKclub,
  handleEnableAllUserByRoleService,
  handleEnableStudentOfDepartmentAndBatchByBatchIdService,
  handleEnableStudentByBatch,
  handleEnableStaffAndStudetByUserId,
  handleEnableAdminByUserId,

  // activity
  sendWishingMail,
};

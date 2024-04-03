import {
  Booking,
  BookingStatusEnum,
  DepartmentEnum,
  PrismaClient,
} from "@prisma/client";
import waitingService from "../waiting/waiting.service";
import { CustomError } from "../../handler/customError";
import pdfService, { bookingProps } from "../../util/PDFGenerator";
import {
  formatTimeWithAMPM,
  getCurrentCambodiaDate,
} from "../../util/formatingData";
const prisma = new PrismaClient();

const selectBookingDefault = {
  id: true,
  payStatus: true,
  status: true,
  schedule: {
    select: {
      id: true,
      date: true,
      departure: {
        select: {
          id: true,
          departureTime: true,
          from: {
            select: {
              id: true,
              mainLocationName: true,
            },
          },
          destination: {
            select: {
              id: true,
              mainLocationName: true,
            },
          },
        },
      },
    },
  },
  user: {
    select: {
      id: true,
      email: true,
      username: true,
      role: true,
      phone: true,
      gender: true,
      inKRR: true,
      enable: true,
    },
  },
  createdAt: true,
  updatedAt: true,
};

const selectWaitingDefault = {
  id: true,
  payStatus: true,
  status: true,
  schedule: {
    select: {
      id: true,
      date: true,
      departure: {
        select: {
          id: true,
          departureTime: true,
          from: {
            select: {
              id: true,
              mainLocationName: true,
            },
          },
          destination: {
            select: {
              id: true,
              mainLocationName: true,
            },
          },
        },
      },
    },
  },
  user: {
    select: {
      id: true,
      email: true,
      username: true,
      role: true,
      phone: true,
      gender: true,
      inKRR: true,
      enable: true,
    },
  },
  createdAt: true,
  updatedAt: true,
};

// check whatever user is booking with this schedule or not: if user exist in booking with this scheduleId -> user cant book
async function checkExistingBooking(userId: string, scheduleId: string) {
  return await prisma.booking.findUnique({
    where: {
      userId_scheduleId: {
        userId,
        scheduleId,
      },
    },
  });
}
// check wahtever user is in waiting list already or not: if user in waiting -> user cant book
async function checkExistingWaiting(userId: string, scheduleId: string) {
  return await prisma.waitting.findUnique({
    where: {
      userId_scheduleId: {
        userId,
        scheduleId,
      },
    },
  });
}

async function createBookingService(book: Booking) {
  // check ticket:
  const userId = book.userId;
  const getTicketsbyUserId = await prisma.ticket.findUnique({
    where: { userId: userId },
  });

  let maxNumberOfTicket = 36;
  if (getTicketsbyUserId && getTicketsbyUserId.remainTicket <= 0) {
    throw new CustomError(
      400,
      `You can't book anymore, you have used all your ticket ${maxNumberOfTicket}`
    );
  }

  // check available schedule:
  const getScheduleByBookingId = await prisma.schedule.findUnique({
    where: {
      id: book.scheduleId,
    },
  });
  if (!getScheduleByBookingId) {
    throw new CustomError(404, "Schedule not found");
  } else if (getScheduleByBookingId && !getScheduleByBookingId.enable) {
    throw new CustomError(400, "This schedule is already closed");
  }

  // check user have booking already or not:
  const existingBooking = await checkExistingBooking(
    book.userId,
    book.scheduleId
  );

  if (existingBooking) {
    throw new CustomError(
      409,
      "your booking with this schedule is already exist in booking list"
    );
  }
  // check user in waiting already or not:
  const existingWaiting = await checkExistingWaiting(
    book.userId,
    book.scheduleId
  );
  if (existingWaiting) {
    throw new CustomError(
      409,
      "your booking with this schedule is already exist in waiting list"
    );
  }
  // check number of booking of userId
  const isExisted = await prisma.booking.findMany({
    where: {
      AND: [{ userId: book.userId }, { status: "BOOKED" }], // I put "USED" becasue when admin validate --> USED and if admin nvalidate and this user come and book again
    },
  });

  // check number of waiting of userId
  const isWaitting = await prisma.waitting.findMany({
    where: {
      AND: [{ userId: book.userId }, { status: "WAITING" }],
    },
  });

  // find number of booking for schedule
  const bookedAmountFromScheduleId = await prisma.booking.count({
    where: {
      AND: [
        { scheduleId: book.scheduleId },
        { status: { in: ["BOOKED", "USED"] } },
      ],
    },
  });

  const guestAmountFromScheduleId = await prisma.guestInfor.count({
    where: {
      scheduleId: book.scheduleId,
    },
  });
  // easy to make change number ticket inHand
  let maxTicketInhand = 2;
  let defaultNumberOfSeat = 24;
  // number of seat for each departure
  const numOfSeat =
    getScheduleByBookingId?.availableSeat || defaultNumberOfSeat;
  if (getTicketsbyUserId!.ticketLimitInhand < maxTicketInhand) {
    if (isExisted.length + isWaitting.length >= maxTicketInhand) {
      throw new CustomError(
        400,
        `You can't book more than ${maxTicketInhand} tickets inhand`
      );
    } else {
      await prisma.ticket.update({
        where: { userId: book.userId },
        data: {
          remainTicket: getTicketsbyUserId!.remainTicket - 1,
          ticketLimitInhand: getTicketsbyUserId!.ticketLimitInhand + 1,
        },
      });
      if (bookedAmountFromScheduleId + guestAmountFromScheduleId >= numOfSeat) {
        const waitingUser = await prisma.waitting.create({
          data: {
            userId: book.userId,
            scheduleId: book.scheduleId,
            updatedAt: null,
          },
          select: selectWaitingDefault,
        });
        return waitingUser;
      } else {
        book.updatedAt = null;
        const userBooking = await prisma.booking.create({
          data: book,
          select: selectBookingDefault,
        });
        return userBooking;
      }
    }
  } else {
    throw new CustomError(
      400,
      `You have used all the tickets in hand, which is ${maxTicketInhand} tickets`
    );
  }
}

// done
async function getAllBookingService() {
  const bookingData = await prisma.booking.findMany({
    select: selectBookingDefault,
    orderBy: {
      createdAt: "desc",
    },
  });
  return bookingData;
}

async function getAllBookingPaginatedService(limit: number, page: number) {
  const total = await prisma.booking.count();
  const pages = Math.ceil(total / limit);
  if (page > pages && pages !== 0) {
    throw new CustomError(400, `Sorry maximum page is ${pages}`);
  }

  const res = await prisma.booking.findMany({
    take: limit,
    skip: (page - 1) * limit,
    select: selectBookingDefault,
    orderBy: {
      createdAt: "desc",
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
// done
async function getBookingByIdService(id: string) {
  const bookingUser = await prisma.booking.findUnique({
    where: {
      id: id,
    },
    select: selectBookingDefault,
  });

  return bookingUser;
}
// done
async function swapBookingService(
  fromBookedId: string,
  withWaitingId: string,
  scheduleId: string
) {
  // check swaping must have same scheduleId(same direction)
  const scheduleOfBooking = await prisma.booking.findUnique({
    where: {
      id: fromBookedId,
    },
  });
  const scheduleOfWaiting = await prisma.waitting.findUnique({
    where: {
      id: withWaitingId,
    },
  });
  if (scheduleOfBooking?.scheduleId !== scheduleOfWaiting?.scheduleId) {
    throw new CustomError(400, `Both users must have the same scheduleId`);
  }
  if (
    scheduleOfBooking?.scheduleId !== scheduleId ||
    scheduleOfWaiting?.scheduleId !== scheduleId
  ) {
    throw new CustomError(
      400,
      `user1 and user2 must have scheduleId match with scheduleId(param)`
    );
  }

  const bookingInSchedule = await getBookingByScheduleIdService(scheduleId);
  const waitingInSchedule = await waitingService.getWaitingByScheduleIdService(
    scheduleId
  );

  const isExistInBooking = (await bookingInSchedule).filter(
    (book) => book.id === fromBookedId
  );
  const isExistInWaiting = (await waitingInSchedule).filter(
    (book: { id: string }) => book.id === withWaitingId
  );

  await prisma.booking.delete({
    where: {
      id: isExistInBooking[0].id,
    },
  });
  const getTicketsbyUserId = await prisma.ticket.findUnique({
    where: { userId: isExistInBooking[0].user.id },
  });
  await prisma.ticket.update({
    where: { userId: isExistInBooking[0].user.id },
    data: {
      remainTicket: getTicketsbyUserId!.remainTicket + 1,
      ticketLimitInhand:
        getTicketsbyUserId!.ticketLimitInhand <= 0
          ? 0
          : getTicketsbyUserId!.ticketLimitInhand - 1,
    },
  });
  await prisma.waitting.delete({
    where: {
      id: isExistInWaiting[0].id,
    },
  });
  const newBookingUser = await prisma.booking.create({
    data: {
      userId: isExistInWaiting![0].user.id,
      scheduleId: isExistInWaiting![0].schedule.id,
      payStatus: true,
      status: "BOOKED",
    },
    select: selectBookingDefault,
  });
  return newBookingUser;
}
// done
async function cancelBookingOrWaitingService(id: string) {
  const isExistInBooking = await prisma.booking.findUnique({
    where: { id },
  });

  const isExistInWaiting = await prisma.waitting.findUnique({
    where: { id },
  });

  const userId = isExistInBooking
    ? isExistInBooking.userId
    : isExistInWaiting?.userId;
  const scheduleId = isExistInBooking
    ? isExistInBooking.scheduleId
    : isExistInWaiting?.scheduleId;
  // --creare cancel user:
  await prisma.cancel.create({
    data: {
      userId: userId || "",
      scheduleId: scheduleId || "",
    },
  });

  // get current ticker of user
  const currentTicketInfo = await prisma.ticket.findUnique({
    where: { userId: userId },
  });

  // refun ticket to user:
  await prisma.ticket.update({
    where: { userId },
    data: {
      remainTicket: currentTicketInfo!.remainTicket + 1,
      ticketLimitInhand:
        currentTicketInfo!.ticketLimitInhand > 0
          ? currentTicketInfo!.ticketLimitInhand - 1
          : 0,
    },
  });

  // if user is in booking list
  if (isExistInBooking) {
    // --delete user from booking list
    const userDeleteFromBooking = await prisma.booking.delete({
      where: { id },
      select: selectBookingDefault,
    });

    // -get first user in waiting list
    const getFirstBookedInWaiting = await prisma.waitting.findFirst({
      where: {
        scheduleId,
      },
    });

    // -if waiting list is not empty: 1. delete from booking and 2.create new booking user
    if (getFirstBookedInWaiting) {
      await prisma.waitting.delete({
        where: { id: getFirstBookedInWaiting!.id },
        select: selectWaitingDefault,
      });

      await prisma.booking.create({
        data: {
          userId: getFirstBookedInWaiting!.userId,
          scheduleId: getFirstBookedInWaiting!.scheduleId,
          payStatus: true,
          status: "BOOKED",
        },
      });
    }

    // -if waiting list is empty: then just return
    return userDeleteFromBooking;
  }

  // if user is in Waiting list
  else if (isExistInWaiting) {
    return await prisma.waitting.delete({
      where: { id },
      select: selectWaitingDefault,
    });
  }
}
// done
async function getBookingByScheduleIdService(id: string) {
  const bookingList = await prisma.booking.findMany({
    where: {
      scheduleId: id,
    },
    select: selectBookingDefault,
    orderBy: {
      createdAt: "asc",
    },
  });
  return bookingList;
}

async function getBookingByScheduleIdPaginatedService(
  id: string,
  litmit: number,
  page: number
) {
  const total = await prisma.booking.count();
  const pages = Math.ceil(total / litmit);
  if (page > pages && pages !== 0) {
    throw new CustomError(400, `Sorry maximum page is ${pages}`);
  }
  const res = await prisma.booking.findMany({
    take: litmit,
    skip: (page - 1) * litmit,
    where: {
      // AND: [{ scheduleId: id }, { status: "BOOKED" }],
      scheduleId: id,
    },
    select: selectBookingDefault,
    orderBy: {
      createdAt: "asc",
    },
  });
  return {
    pagination: {
      totalData: total,
      totalPage: pages,
      dataPerPage: litmit,
      currentPage: page,
    },
    data: res,
  };
}

async function exportPDFBookingByScheduleIdService(id: string) {
  const scheduleDetail = await prisma.schedule.findUnique({
    where: {
      id,
    },
    select: {
      id: true,
      date: true,
      departure: {
        select: {
          id: true,
          departureTime: true,
          from: {
            select: {
              id: true,
              mainLocationName: true,
            },
          },
          destination: {
            select: {
              id: true,
              mainLocationName: true,
            },
          },
        },
      },
      guestInfor: true,
    },
  });
  const dateStr =
    scheduleDetail?.date
      .toLocaleDateString("en-GB", {
        day: "2-digit",
        month: "2-digit",
        year: "numeric",
      })
      .split("/")
      .join("-") || "---:---";
  const departureTime =
    scheduleDetail?.departure.departureTime.toLocaleTimeString([], {
      hour: "2-digit",
      minute: "2-digit",
    });
  const allStudent = await prisma.booking.findMany({
    where: {
      scheduleId: id,
      status: {
        in: ["BOOKED", "USED"],
      },
    },
    select: {
      id: true,
      user: {
        include: {
          studentInfo: {
            include: {
              batch: true,
            },
          },
        },
      },
      schedule: {
        select: {
          date: true,
          departure: {
            select: {
              id: true,
              departureTime: true,
              from: {
                select: {
                  id: true,
                  mainLocationName: true,
                },
              },
              destination: {
                select: {
                  id: true,
                  mainLocationName: true,
                },
              },
            },
          },
        },
      },
      status: true,
    },
  });
  const allGuest = scheduleDetail?.guestInfor;
  const directionHeader = `${scheduleDetail?.departure.from.mainLocationName} - ${scheduleDetail?.departure.destination.mainLocationName}`;
  const direction = `${scheduleDetail?.departure.from.mainLocationName} > ${scheduleDetail?.departure.destination.mainLocationName}`;

  let data: bookingProps[] = [];

  // push guest to list:
  allGuest?.map((guest) => {
    const guestData = {
      username: guest.name,
      phone: "---:---",
      gender: guest.gender,
      batch: "---:---",
      role: guest.user_type,
      departureDate: dateStr,
      from_to: direction,
      departureTime: departureTime,
    } as bookingProps;
    // userList.push(guestData)
    data.push(guestData);
  });
  // push student:
  allStudent.map((user) => {
    const shortCurt_dept =
      user.user.studentInfo?.batch?.department === "SOFTWAREENGINEERING"
        ? "DSE"
        : user.user.studentInfo?.batch?.department === "TOURISMANDMANAGEMENT"
        ? "DTM"
        : user.user.studentInfo?.batch?.department === "ARCHITECTURE"
        ? "DAC"
        : "KIT/GUEST";
    const shortCurt_batch =
      user.user.role == "STUDENT"
        ? `${shortCurt_dept}-B${user.user.studentInfo?.batch?.batchNum
            ?.toString()
            .padStart(2, "0")}`
        : "KIT/GUEST";
    const userData = {
      username: user.user.username,
      phone: user.user.phone || "---:---",
      gender: user.user.gender,
      batch: shortCurt_batch,
      role: user.user.role,
      departureDate: dateStr,
      from_to: direction,
      departureTime: departureTime,
    } as bookingProps;
    // userList.push(userData)
    data.push(userData);
  });

  // Looping through Alluser data:
  const formattedData = data?.map((userDt: any, index: number) => {
    let shortCurt_gender =
      userDt.gender === "MALE"
        ? "M"
        : userDt.gender === "FEMALE"
        ? "F"
        : "---:---";
    return {
      index: index + 1,
      username: userDt.username,
      gender: shortCurt_gender,
      batch: userDt.batch,
      role: userDt.role,
      departureDate: dateStr,
      from_to: direction,
      phone: userDt.phone,
      departureTime: departureTime,
    } as bookingProps;
  });

  const currentDateUTC = new Date();
  // Adjusting for Cambodia time (UTC+7)
  const cambodiaDateUTC = new Date(
    currentDateUTC.getTime() + 7 * 60 * 60 * 1000
  );

  const currentDate = getCurrentCambodiaDate();
  const camHour = formatTimeWithAMPM(cambodiaDateUTC);
  const createAt = `${currentDate} ${camHour}`;

  const res = await pdfService.downloadBookingOfScheduleToPDF(
    formattedData,
    directionHeader,
    dateStr,
    createAt
  );
  return res;
}
// done
// service: generate booking by Date: "yy-mm-dd"
async function exportPDFBookingByDateService(date: Date) {
  const allSchedule = await prisma.schedule.findMany({
    where: {
      date: new Date(date),
    },
    select: {
      id: true,
      date: true,
      departureId: true,
      departure: {
        select: {
          departureTime: true,
          from: {
            select: {
              id: true,
              mainLocationName: true,
            },
          },
          destination: {
            select: {
              id: true,
              mainLocationName: true,
            },
          },
        },
      },
      booking: {
        select: {
          id: true,
          user: {
            select: {
              email: true,
              username: true,
              gender: true,
              role: true,
              phone: true,
              studentInfo: {
                select: {
                  batch: true,
                },
              },
            },
          },
        },
      },
      guestInfor: true,
    },
  });

  // array of all data:
  // array of all data:
  const data: { direction: string; data: bookingProps[] }[] = [];

  const dateStr = date
    .toLocaleDateString("en-GB", {
      day: "2-digit",
      month: "2-digit",
      year: "numeric",
    })
    .split("/")
    .join("-");
  allSchedule.forEach((eachSchedule) => {
    let bookingOfEachSched = eachSchedule.booking;
    let guestOfEachSched = eachSchedule.guestInfor;
    // let departureDate = eachSchedule?.date;
    let from_to = `${eachSchedule.departure.from.mainLocationName} > ${eachSchedule.departure.destination.mainLocationName}`;
    let direction = `${eachSchedule.departure.from.mainLocationName} - ${eachSchedule.departure.destination.mainLocationName}`;
    let departureTime = eachSchedule.departure.departureTime.toLocaleTimeString(
      [],
      { hour: "2-digit", minute: "2-digit" }
    );

    // format data from booking list and push to array:
    let bookingFtGuestArray: bookingProps[] = [];

    // format data from guest list and push to array:
    guestOfEachSched.forEach((guestInfor, index) => {
      let shortCurt_gender =
        guestInfor.gender === "MALE"
          ? "M"
          : guestInfor.gender === "FEMALE"
          ? "F"
          : "---:---";

      let guestFormated: bookingProps = {
        index: index + 1,
        username: guestInfor.name,
        gender: shortCurt_gender,
        batch: "KIT/GUEST" || "---:---",
        role: guestInfor.user_type || "---:---",
        departureDate: dateStr,
        from_to: from_to,
        phone: "---:---",
        departureTime: departureTime,
      };

      bookingFtGuestArray.push(guestFormated);
    });

    // format data from booking list and push to array:
    bookingOfEachSched.forEach((userInfor) => {
      let shortCurt_dept =
        userInfor.user.studentInfo?.batch?.department === "SOFTWAREENGINEERING"
          ? "DSE"
          : userInfor.user.studentInfo?.batch?.department ===
            "TOURISMANDMANAGEMENT"
          ? "DTM"
          : userInfor.user.studentInfo?.batch?.department === "ARCHITECTURE"
          ? "DAC"
          : "KIT";
      let shortCurt_batch =
        userInfor.user.role == "STUDENT"
          ? `${shortCurt_dept}-B${userInfor.user.studentInfo?.batch?.batchNum
              ?.toString()
              .padStart(2, "0")}`
          : "---:---";
      let shortCurt_gender =
        userInfor.user.gender === "MALE"
          ? "M"
          : userInfor.user.gender === "FEMALE"
          ? "F"
          : "---:---";

      let bookingFormated: bookingProps = {
        index: bookingFtGuestArray.length + 1,
        username: userInfor.user.username || "---:---",
        gender: shortCurt_gender,
        batch: shortCurt_batch,
        role: userInfor.user.role || null,
        departureDate: dateStr,
        from_to: from_to,
        phone: userInfor.user.phone || "---:---",
        departureTime: departureTime,
      };

      bookingFtGuestArray.push(bookingFormated);
    });

    // Push array of bookings for each schedule into the main array
    data.push({ direction: direction, data: bookingFtGuestArray });
  });

  const currentDateUTC = new Date();
  // Adjusting for Cambodia time (UTC+7)
  const cambodiaDateUTC = new Date(
    currentDateUTC.getTime() + 7 * 60 * 60 * 1000
  );

  const currentDate = getCurrentCambodiaDate();
  const camHour = formatTimeWithAMPM(cambodiaDateUTC);
  const createAt = `${currentDate} ${camHour}`;
  const pdfBuffer = await pdfService.downloadBookingOfMutipleScheduleToPDF(
    data,
    dateStr,
    createAt
  );
  return pdfBuffer;
}
// done
// service: get booking and waiting filter by date
async function getAllBookingAndWaitingFilterByDateService(date: Date) {
  const userListBooking = await prisma.booking.findMany({
    where: {
      schedule: {
        date: new Date(date),
      },
    },
    select: selectBookingDefault,
    orderBy: {
      createdAt: "asc",
    },
  });

  const userListWaiting = await prisma.waitting.findMany({
    where: {
      schedule: {
        date: new Date(date),
      },
    },
    select: selectWaitingDefault,
    orderBy: {
      createdAt: "asc",
    },
  });

  const users = {
    booking: userListBooking,
    waiting: userListWaiting,
  };
  return users;
}

// done
// service: get booking by batch(department and batchnumber) and date
async function getBookingAndWaitingFilterByDepartmentBatchAndDateService(
  department: DepartmentEnum,
  batchNum: number,
  date: Date
) {
  // check department and batchNum exist:
  const existingBatch = await prisma.batch.findUnique({
    where: {
      department_batchNum: {
        department,
        batchNum,
      },
    },
  });
  if (!existingBatch) {
    throw new CustomError(204, `department and batch number is not exist`);
  }

  // check date exist:
  const existingDateOfSchedule = await prisma.schedule.findFirst({
    where: {
      date: new Date(date),
    },
  });
  if (!existingDateOfSchedule) {
    throw new CustomError(204, `date is not exist on schedule`);
  }

  // query date Booking:
  const bookingList = await prisma.booking.findMany({
    where: {
      AND: [
        {
          schedule: {
            date: new Date(date),
          },
        },
        {
          user: {
            studentInfo: {
              batch: {
                AND: [
                  { department: department as DepartmentEnum },
                  { batchNum: batchNum },
                ],
              },
            },
          },
        },
      ],
    },
    orderBy: {
      createdAt: "asc",
    },
    select: selectBookingDefault,
  });

  // query date Waiting:
  const waitingList = await prisma.waitting.findMany({
    where: {
      AND: [
        {
          schedule: {
            date: new Date(date),
          },
        },
        {
          user: {
            studentInfo: {
              batch: {
                AND: [
                  { department: department as DepartmentEnum },
                  { batchNum: batchNum },
                ],
              },
            },
          },
        },
      ],
    },
    orderBy: {
      createdAt: "asc",
    },
    select: selectBookingDefault,
  });

  const dataUsers = {
    booking: bookingList,
    waiting: waitingList,
  };
  return dataUsers;
}
// done
// service: get booking by date, departmentName
async function getAllBookingAndWaitingByDateAndDepartmentService(
  date: Date,
  department: DepartmentEnum
) {
  // check date is exist:
  const existingDateOfSchedule = await prisma.schedule.findMany({
    where: {
      date: new Date(date),
    },
  });

  if (existingDateOfSchedule.length === 0) {
    throw new CustomError(404, `date is not exist on schedule`);
  }
  const bookingList = await prisma.booking.findMany({
    where: {
      AND: [
        {
          schedule: {
            date: new Date(date),
          },
        },
        {
          user: {
            studentInfo: {
              batch: {
                department: department as DepartmentEnum,
              },
            },
          },
        },
      ],
    },
    select: selectBookingDefault,
    orderBy: {
      createdAt: "asc",
    },
  });
  const waitingList = await prisma.waitting.findMany({
    where: {
      schedule: {
        date: new Date(date),
      },
      user: {
        studentInfo: {
          batch: {
            department: department as DepartmentEnum,
          },
        },
      },
    },
    select: selectBookingDefault,
    orderBy: {
      createdAt: "asc",
    },
  });

  const dataUsers = {
    booking: bookingList,
    waiting: waitingList,
  };
  return dataUsers;
}
async function getAllBookingByUserIdService(userId: string) {
  const bookingList = await prisma.booking.findMany({
    where: {
      userId: userId,
      status: BookingStatusEnum.BOOKED,
    },
    select: {
      id: true,
      status: true,
      schedule: {
        select: {
          id: true,
          date: true,
          departure: {
            select: {
              id: true,
              from: true,
              destination: true,
              dropLocation: true,
              departureTime: true,
              pickupLocation: true,
            },
          },
          bus: {
            select: {
              id: true,
              model: true,
              plateNumber: true,
              numOfSeat: true,
              driverName: true,
              driverContact: true,
            },
          },
        },
      },

      createdAt: true,
      updatedAt: true,
    },
    orderBy: {
      createdAt: "asc",
    },
  });
  return bookingList;
}

async function getAllPaginatedBookingByUserIdService(
  userId: string,
  limit: number,
  page: number
) {
  const res = await prisma.booking.findMany({
    take: limit,
    skip: (page - 1) * limit,
    where: {
      userId: userId,
      status: BookingStatusEnum.BOOKED,
    },
    select: {
      id: true,
      status: true,
      schedule: {
        select: {
          id: true,
          date: true,
          departure: {
            select: {
              id: true,
              from: true,
              destination: true,
              dropLocation: true,
              departureTime: true,
              pickupLocation: true,
            },
          },
          bus: {
            select: {
              id: true,
              model: true,
              plateNumber: true,
              numOfSeat: true,
              driverName: true,
              driverContact: true,
            },
          },
        },
      },

      createdAt: true,
      updatedAt: true,
    },
    orderBy: {
      createdAt: "asc",
    },
  });
  const total = await prisma.booking.count({
    where: {
      userId: userId,
      status: BookingStatusEnum.BOOKED,
    },
  });
  const pages = Math.ceil(total / limit);
  if (page > pages && pages !== 0) {
    throw new CustomError(400, `Sorry maximum page is ${pages}`);
  }
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
async function getAllBookingHistoryByUserIdService(id: string) {
  return await prisma.booking.findMany({
    where: {
      userId: id,
      status: BookingStatusEnum.USED,
    },
    select: {
      id: true,
      status: true,
      schedule: {
        select: {
          id: true,
          date: true,
          departure: {
            select: {
              id: true,
              from: true,
              destination: true,
              dropLocation: true,
              departureTime: true,
              pickupLocation: true,
            },
          },
          bus: {
            select: {
              id: true,
              model: true,
              plateNumber: true,
              numOfSeat: true,
              driverName: true,
              driverContact: true,
            },
          },
        },
      },
      createdAt: true,
      updatedAt: true,
    },
    orderBy: {
      createdAt: "desc",
    },
  });
}

async function getAllPaginatedBookingHistoryByUserIdService(
  id: string,
  limit: number,
  page: number
) {
  const res = await prisma.booking.findMany({
    take: limit,
    skip: (page - 1) * limit,
    where: {
      userId: id,
      status: BookingStatusEnum.USED,
    },
    select: {
      id: true,
      status: true,
      schedule: {
        select: {
          id: true,
          date: true,
          departure: {
            select: {
              id: true,
              from: true,
              destination: true,
              dropLocation: true,
              departureTime: true,
              pickupLocation: true,
            },
          },
          bus: {
            select: {
              id: true,
              model: true,
              plateNumber: true,
              numOfSeat: true,
              driverName: true,
              driverContact: true,
            },
          },
        },
      },
      createdAt: true,
      updatedAt: true,
    },
    orderBy: {
      createdAt: "desc",
    },
  });
  const total = await prisma.booking.count({
    where: {
      userId: id,
      status: BookingStatusEnum.USED,
    },
  });
  const pages = Math.ceil(total / limit);
  if (page > pages && pages !== 0) {
    throw new CustomError(400, `Sorry maximum page is ${pages}`);
  }
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

export default {
  getAllBookingHistoryByUserIdService,
  getAllPaginatedBookingHistoryByUserIdService,
  createBookingService,
  getAllBookingService,
  getAllBookingPaginatedService,
  getBookingByIdService,
  exportPDFBookingByScheduleIdService,
  exportPDFBookingByDateService,
  cancelBookingOrWaitingService,
  getBookingByScheduleIdService,
  getBookingByScheduleIdPaginatedService,
  swapBookingService,
  getAllBookingAndWaitingFilterByDateService,
  getBookingAndWaitingFilterByDepartmentBatchAndDateService,
  getAllBookingAndWaitingByDateAndDepartmentService,
  getAllBookingByUserIdService,
  getAllPaginatedBookingByUserIdService,
};

import { schedules } from "./../../util/autoValidate";
import { DepartureDto } from "./../../payload/request/departureDto";
import { PrismaClient } from "@prisma/client";
import bookingService from "../booking/booking.service";
import busService from "../bus/bus.service";
import {
  BlockSeatUserDto,
  ScheduleDto,
  ScheduleResponseDto,
} from "./../../payload/request/scheduleDto";
import waitingService from "../waiting/waiting.service";
import mainLocationService from "../mainLocation/mainLocation.service";
import subLocationService from "../subLocation/subLocation.service";
import departureService from "../departure/departure.service";
import { CustomError } from "../../handler/customError";
import { SubLocationDto } from "../../payload/request/subLocatonDto";
import updateUserStatusLaundry from "../../services/laundry.service";
import { combineDateTime } from "../../util/formatingData";
import bus from "../bus";

const readXlsxFile = require("read-excel-file/node");
const prisma = new PrismaClient();

const selectDefault = {
  id: true,
  date: true,
  numberOfblock: true,
  availableSeat: true,
  departureId: true,
  enable: true,
  departure: {
    select: {
      id: true,
      departureTime: true,
      from: true,
      destination: true,
      pickupLocation: true,
      dropLocation: true,
    },
  },
  guestInfor: true,
  booking: {
    select: {
      id: true,
      user: {
        select: {
          id: true,
          username: true,
        },
      },
    },
  },
  Waitting: {
    select: {
      id: true,
      user: {
        select: {
          id: true,
          username: true,
        },
      },
    },
  },
  Cancel: {
    select: {
      id: true,
      user: {
        select: {
          id: true,
          username: true,
        },
      },
    },
  },
  bus: true,
};
function areStringsSameIgnoringSpaces(str1: string, str2: string) {
  // Remove all spaces from both strings
  const normalizedStr1 = str1.replace(/\s+/g, "").toLowerCase();
  const normalizedStr2 = str2.replace(/\s+/g, "").toLowerCase();

  // Compare the normalized strings
  return normalizedStr1 === normalizedStr2;
}

function normalizeName(name: string) {
  return name.replace(/\s+/g, "");
}
async function batchCreateScheduleService(file: any) {
  interface schedulesDetail {
    from: string;
    destination: string;
    time: Date;
    pickup: string;
    drop: string;
    date: Date;
    seat: number;
  }
  interface importSchedulesFailRespone {
    row: number;
    status: boolean;
    message: string;
    detail: schedulesDetail;
  }

  const dataOfCreateFail: importSchedulesFailRespone[] = [];
  const dataOfCreated: any[] = [];
  const res = await readXlsxFile(Buffer.from(file.buffer)).then(
    async (data: any) => {
      // i choose i start from 5 because the first 5 rows are header
      // i choose i += 2 because i merge 1 cell as 2 colum in sheet
      // i use j st6art from 1 to count row of data
      for (let i = 5, j = 1; i < data.length; i += 2, j++) {
        console.log(`--------------- row ${i} --------------------`);
        const from = data[i][0];
        const destination = data[i][2];
        const inputTime = data[i][4];
        const pickup = data[i][6];
        const drop = data[i][8];
        const inputDate = data[i][10];
        const seat = data[i][12];
        const row = j;
        console.log("from:", from);
        console.log("destination:", destination);
        console.log("time:", inputTime);
        console.log("pickup:", pickup);
        console.log("drop:", drop);
        console.log("date:", inputDate);
        console.log("seat:", seat);

        try {
          const listOfMainLoc = await prisma.mainLocation.findMany({
            select: {
              id: true,
              mainLocationName: true,
            },
          });
          // from location
          // -- purpose of doing this : want to check like "Phnom Penh" and "phnompenh" are same
          var fromLocation = listOfMainLoc.find(
            (item: { id: string; mainLocationName: string }) => {
              return areStringsSameIgnoringSpaces(item.mainLocationName, from);
            }
          );
          if (!fromLocation) {
            console.log("- create MainLocation for From ....");
            fromLocation = await prisma.mainLocation.create({
              data: {
                mainLocationName: from,
              },
            });
            console.log("- ❎ MainLocation of From created");
            console.log("");
          } else {
            console.log("- ❌ MainLocation of From is already existed ....");
          }

          // destination location
          // -- purpose of doing this : want to check like "Phnom Penh" and "phnompenh" are same
          var destinationLoc = listOfMainLoc.find(
            (item: { id: string; mainLocationName: string }) => {
              return areStringsSameIgnoringSpaces(
                item.mainLocationName,
                destination
              );
            }
          );

          if (!destinationLoc) {
            console.log("- create MainLocation for destination ....");
            destinationLoc = await prisma.mainLocation.create({
              data: {
                mainLocationName: destination,
              },
            });
            console.log("- ❎ MainLocation of destination created");
            console.log("");
          } else {
            console.log(
              "- ❌ MainLocation of destination is already existed ...."
            );
          }

          // ---- sub location:
          const listOfSubLocOfFromLoc = await prisma.subLocation.findMany({
            where: {
              mainLocationId: fromLocation?.id,
            },
          });

          // pickup location
          var pickupLoc = listOfSubLocOfFromLoc.find(
            (item: { id: string; subLocationName: string }) => {
              return areStringsSameIgnoringSpaces(item.subLocationName, pickup);
            }
          );

          if (!pickupLoc) {
            console.log("- create subLocation for pickupLocation ....");
            pickupLoc = await prisma.subLocation.create({
              data: {
                mainLocationId: fromLocation?.id || "",
                subLocationName: pickup,
              },
            });
            console.log("- ❎ subLocation for pickupLocation created");
            console.log("");
          } else {
            console.log(
              "- ❌ subLocation for pickupLocation is already existed ...."
            );
          }

          // drop location
          const listOfSubLocOfDestinationLoc =
            await prisma.subLocation.findMany({
              where: {
                mainLocationId: destinationLoc?.id,
              },
            });
          var dropOffLoc = await listOfSubLocOfDestinationLoc.find(
            (item: { id: string; subLocationName: string }) => {
              return areStringsSameIgnoringSpaces(item.subLocationName, drop);
            }
          );
          if (!dropOffLoc) {
            console.log("- create subLocation for dropOffLocation ....");
            dropOffLoc = await prisma.subLocation.create({
              data: {
                mainLocationId: destinationLoc.id,
                subLocationName: drop,
              },
            });
            console.log("- ❎ subLocation for dropOffLocation created");
            console.log("");
          } else {
            console.log(
              "- ❌ subLocation for dropOffLocation is already existed ...."
            );
          }

          const departureTime = new Date("1970-01-01T00:00:00.000Z");
          departureTime.setUTCHours(
            inputTime.getUTCHours(),
            inputTime.getUTCMinutes()
          );
          const departure = {
            fromId: fromLocation?.id || "",
            destinationId: destinationLoc.id,
            departureTime: departureTime,
            pickupLocationId: pickupLoc?.id,
            dropLocationId: dropOffLoc?.id,
          };
          var checkDeparture =
            await departureService.getDepartureByFromIdDestinationIdAndDepartureTime(
              departure.fromId,
              departure.destinationId,
              departure.departureTime
            );

          if (!checkDeparture) {
            console.log("- create departure ....");
            // await departureService.createDepartureService(departure as DepartureDto)
            checkDeparture = await prisma.departure.create({
              data: departure as DepartureDto,
            });
            console.log("- ❎ departure created ....");
            console.log("");
          } else {
            console.log("- ❌ departure is already existed ....");
          }

          //check schedule
          var checkSchedule = await prisma.schedule.findFirst({
            where: {
              AND: [
                { departureId: checkDeparture!.id },
                { date: new Date(inputDate) },
              ],
            },
            select: selectDefault,
          });
          if (!checkSchedule) {
            console.log("- create schedule ....");
            const schedule = {
              departureId: checkDeparture!.id,
              date: inputDate,
              busId: null,
            };
            checkSchedule = await prisma.schedule.create({
              data: {
                departureId: schedule.departureId,
                date: new Date(schedule.date),
                availableSeat: seat,
                busId: schedule.busId || null, //still null becasue above is null
                numberOfblock: 0,
                enable: true,
              },
              select: selectDefault,
            });

            // push data that created here to array:
            const singleSchedule = await getScheduleByIdService(
              checkSchedule.id
            );
            // listDetailScueduleCreated.push(singleSchedule);
            dataOfCreated.push({
              row: row,
              status: true,
              message: "✅ Schedule created",
              detail: singleSchedule,
            });

            console.log(` **✅ schedule for row ${row} created`);
            console.log("");
          } else {
            console.log("- ❌ schedule is already existed ....");
            throw new CustomError(
              409,
              `Schedule in row ${row} is already existed`
            );
          }
        } catch (error: any) {
          const errorStatusCode = error.statusCode;
          if (errorStatusCode === 409) {
            dataOfCreateFail.push({
              row,
              status: false,
              message: `${error.message}`,
              detail: {
                from,
                destination,
                time: inputTime,
                pickup,
                drop,
                date: inputDate,
                seat,
              },
            });
          } else {
            dataOfCreateFail.push({
              row,
              status: false,
              message: `Error processing during creating schedule ${error.message}`,
              detail: {
                from,
                destination,
                time: inputTime,
                pickup,
                drop,
                date: inputDate,
                seat,
              },
            });
          }
          console.error(`Error processing row ${row} : ${error.message}`);
          // Continue to the next iteration of the loop
          continue;
        }
      }
      return {
        failToCreate: dataOfCreateFail,
        successCreate: dataOfCreated,
      };
    }
  );
  return res;
}

// get Unique Schedule: by dapartureId and busId:
async function getScheduleByDepartureIdAndDateService(
  departureId: string,
  date: Date,
  busId: string
) {
  return await prisma.schedule.findUnique({
    where: {
      departureId_date_bus: {
        departureId: departureId,
        date: new Date(date),
        busId: busId ?? "",
      },
    },
    select: selectDefault,
  });
}

// get Unique Schedule: by dapartureId and busId:
async function getScheduleByDepartureIdDateAndBusIdService(
  departureId: string,
  date: Date,
  busId: string
) {
  return await prisma.schedule.findFirst({
    where: {
      AND: [{ departureId }, { date }, { busId }],
    },
  });
}

// get all Schedule:
async function getAllScheduleService() {
  return await prisma.schedule.findMany({
    select: selectDefault,
    orderBy: {
      date: "desc",
    },
  });
}

async function getAllSchedulePaginatedService(limit: number, page: number) {
  const total = await prisma.schedule.count();
  const pages = Math.ceil(total / limit);
  if (page > pages && pages !== 0)
    throw new CustomError(400, `Sorry maximum page is ${pages}`);
  const res = await prisma.schedule.findMany({
    take: limit,
    skip: (page - 1) * limit,
    select: selectDefault,
    orderBy: {
      date: "desc",
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
// get Schedule by Id:
async function getScheduleByIdService(id: string) {
  const data = await prisma.schedule.findUnique({
    where: {
      id,
    },
    select: {
      id: true,
      date: true,
      numberOfblock: true,
      availableSeat: true,
      departureId: true,
      enable: true,
      departure: {
        select: {
          id: true,
          departureTime: true,
          from: true,
          destination: true,
          pickupLocation: true,
          dropLocation: true,
        },
      },
      guestInfor: true,
      booking: {
        orderBy: {
          createdAt: "desc",
        },
        select: {
          id: true,
          user: {
            select: {
              id: true,
              username: true,
            },
          },
        },
      },
      Waitting: {
        orderBy: {
          createdAt: "desc",
        },
        select: {
          id: true,
          user: {
            select: {
              id: true,
              username: true,
            },
          },
        },
      },
      Cancel: {
        select: {
          id: true,
          user: {
            select: {
              id: true,
              username: true,
            },
          },
        },
      },
      bus: true,
    },
  });
  return data;
}

// create schedule
async function createScheduleService(schedule: ScheduleDto) {
  let isDuplicateWithDepartureAndDate;
  let isDuplicateWithDepartureAndDateAndBus;
  let totalAvailableSeat;

  if (schedule.busId === "" || schedule.busId === null) {
    const existingSchedule = await prisma.schedule.findFirst({
      where: {
        AND: [
          { departureId: schedule.departureId },
          { date: new Date(schedule.date) },
        ],
      },
    });
    isDuplicateWithDepartureAndDate = existingSchedule ? true : false;
    if (!existingSchedule) {
      totalAvailableSeat = 24;
    }
  } else if (schedule.busId !== "" && schedule.busId !== null) {
    const existingScheduleWithBus =
      await getScheduleByDepartureIdAndDateService(
        schedule.departureId,
        schedule.date,
        schedule.busId
      );
    isDuplicateWithDepartureAndDateAndBus = existingScheduleWithBus
      ? true
      : false;
    if (!existingScheduleWithBus) {
      const bus = await busService.getBusByIdService(schedule.busId);
      totalAvailableSeat = bus?.numOfSeat;
    }
  }

  if (isDuplicateWithDepartureAndDate) {
    throw new CustomError(
      409,
      "Schedule is already existed with same departureId and date"
    );
  } else if (isDuplicateWithDepartureAndDateAndBus) {
    throw new CustomError(
      409,
      "Schedule is already existed with same departureId, bus and date"
    );
  }

  try {
    return await prisma.schedule.create({
      data: {
        departureId: schedule.departureId,
        availableSeat: totalAvailableSeat,
        date: new Date(schedule.date),
        busId: schedule.busId || null,
      },
      select: selectDefault,
    });
  } catch (error) {
    console.log(error);
  }
}

// block seat:
async function blockSeatService(
  scheduleId: string,
  listname: BlockSeatUserDto[]
) {
  const schedule = await prisma.schedule.findUnique({
    where: {
      id: scheduleId,
    },
  });

  const countBooking = await prisma.booking.count({
    where: {
      AND: [{ scheduleId }, { status: { in: ["BOOKED", "USED"] } }],
    },
  });
  const countBlockSeat = await prisma.guestInfor.count({
    where: {
      scheduleId,
    },
  });

  const availableSeat =
    Number(schedule?.availableSeat) - (countBooking + countBlockSeat);

  const preBlockSeat = Number(schedule?.numberOfblock);
  if (availableSeat <= 0) {
    throw new CustomError(409, "No available seat");
  } else if (availableSeat < listname.length) {
    throw new CustomError(
      409,
      "Number of block is greater than available seat"
    );
  }
  const newSchedule = await prisma.schedule.update({
    where: {
      id: scheduleId,
    },
    data: {
      // availableSeat: availableSeat - listname.length,
      numberOfblock: preBlockSeat + listname.length,
      guestInfor: {
        createMany: {
          data: listname.map((user) => ({
            name: user?.name,
            gender: user.gender,
          })),
        },
      },
    },
    select: selectDefault,
  });

  if (!newSchedule) throw new CustomError(404, "Fail to block-seat");
  return newSchedule;
}

// remove block-seat:
async function unblockSeatService(scheduleId: string, guestId: string) {
  const guest = await prisma.guestInfor.findUnique({
    where: {
      id: guestId,
    },
  });

  if (!guest) throw new CustomError(404, "Guest not found");

  const getFirstBookedInWaiting = await prisma.waitting.findFirst({
    where: {
      scheduleId,
    },
  });
  // delete data from guestInfor:
  await prisma.schedule.update({
    where: {
      id: scheduleId,
    },
    data: {
      guestInfor: {
        deleteMany: {
          id: guestId,
        },
      },
      numberOfblock: {
        decrement: 1,
      },
    },
  });

  // -if waiting list is not empty: 1. delete from booking and 2.create new booking user
  if (getFirstBookedInWaiting) {
    await prisma.waitting.delete({
      where: { id: getFirstBookedInWaiting!.id },
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
  return guest;
}

// update:
async function updateBlockSeatInfoService(
  scheduleid: string,
  guestId: string,
  blockSeatUserDto: BlockSeatUserDto
) {
  const schedule = await prisma.schedule.findUnique({
    where: { id: scheduleid },
  });
  if (!schedule) throw new CustomError(404, "Schedule not found");
  const guest = await prisma.guestInfor.findUnique({ where: { id: guestId } });
  if (!guest) throw new CustomError(404, "Guest not found");
  const newGuestInfor = await prisma.guestInfor.update({
    where: {
      id: guestId,
    },
    data: blockSeatUserDto,
  });
  return newGuestInfor;
}

// delete Schedule by Id:
async function deleteScheduleByIdService(id: string) {
  const schedule = await getScheduleByIdService(id);
  if (!schedule) {
    throw new CustomError(404, "Schedule not found");
  }
  const scheduleUpdate = await prisma.schedule.delete({
    where: {
      id,
    },
  });
  console.log(scheduleUpdate);
}

// update schedule by Id :
async function updateScheduleByIdService(id: string, schedule: ScheduleDto) {
  const scheduleData = await getScheduleByIdService(id);
  if (!scheduleData) {
    throw new CustomError(401, "Bad request(schedule not found)");
  }

  // check: 3 prop
  const existingScheduleWithBus = await getScheduleByDepartureIdAndDateService(
    schedule.departureId,
    schedule.date,
    schedule.busId
  );

  if (
    existingScheduleWithBus &&
    scheduleData?.departureId === schedule.departureId &&
    scheduleData?.date === new Date(schedule.date)
  ) {
    throw new CustomError(
      409,
      "Schedule is already exist with departure, date annd bus"
    );
  }

  // check 2 prop:
  const existingSchedule = await prisma.schedule.findFirst({
    where: {
      AND: [
        { departureId: schedule.departureId },
        { date: new Date(schedule.date) },
      ],
    },
  });
  if (
    existingSchedule &&
    scheduleData?.departureId === schedule.departureId &&
    scheduleData?.date === new Date(schedule.date)
  ) {
    throw new CustomError(
      409,
      "Schedule is already exist with departure and date"
    );
  }

  // -- if busId is input: numOfSeat >= booking num
  const booking = await bookingService.getBookingByScheduleIdService(id);
  if (schedule.busId) {
    const bus = await busService.getBusByIdService(schedule.busId);
    schedule.availableSeat = bus?.numOfSeat;

    // --- if bus that assigne have numOfSeat < numOfBooking
    if (Number(bus?.numOfSeat) < booking.length) {
      throw new CustomError(
        400,
        "Can't assign bus that have number of seat less than number of booking"
      );
    }
  } else {
    schedule.availableSeat = 24;
  }

  const newSchedule = await prisma.schedule.update({
    where: {
      id,
    },
    data: {
      departureId: schedule.departureId,
      availableSeat: schedule.availableSeat,
      date: new Date(schedule.date),
      busId: schedule.busId || null,
      enable: schedule.enable,
    },
    select: selectDefault,
  });
  if (!newSchedule) throw new CustomError(404, "Fail to update schedule");
  //get all wating by scheduleId: then update to booking
  const getAllWaitingBySchedule =
    await waitingService.getWaitingByScheduleIdService(id);
  const currentSeat = Number(newSchedule.availableSeat);
  if (getAllWaitingBySchedule.length > 0 && currentSeat > booking.length) {
    const numOfNewBookingUsers = currentSeat - booking.length;
    // get new booking users --> find from waitng to put into booking:
    for (let i = 0; i < numOfNewBookingUsers; i++) {
      await prisma.booking.create({
        data: {
          userId: getAllWaitingBySchedule[i].user.id,
          scheduleId: newSchedule.id,
          payStatus: true,
          status: "BOOKED",
        },
      });
      await prisma.waitting.delete({
        where: {
          id: getAllWaitingBySchedule[i].id,
        },
      });
    }
    return newSchedule;
  } else {
    return newSchedule;
  }
}

async function confirmSchedule(scheduleId: string, confirm: boolean) {
  try {
    const schedule = await getScheduleByIdService(scheduleId);

    const books = await prisma.booking.findMany({
      where: {
        AND: [{ scheduleId }, { status: "BOOKED" }],
      },
      include: {
        user: true,
      },
    });

    console.log("books -->", books);
    const listUsers = await prisma.booking.findMany({
      where: {
        AND: [{ scheduleId }, { status: "BOOKED" }],
      },
      select: {
        user: {
          select: {
            email: true,
          },
        },
      },
    });
    const destination =
      schedule?.departure.destination.mainLocationName.toLocaleLowerCase();
    // console.log(destination);
    var userInKrr: (string | null)[] = [];
    var userOutKrr: (string | null)[] = [];

    const isInKRR = destination === "kirirom" ? true : false;
    // set all user Booking to USED
    if (confirm === true) {
      //update booking status to used
      books.forEach(async (item: any) => {
        // update status of booking:
        await prisma.booking.update({
          where: {
            id: item.id,
          },
          data: {
            status: "USED",
          },
        });

        // update status inKRR
        await prisma.user.update({
          where: {
            id: item.userId,
          },
          data: {
            inKRR: isInKRR,
          },
        });

        //  update ticketInhand:
        await prisma.ticket.update({
          where: {
            userId: item.userId,
          },
          data: {
            ticketLimitInhand: {
              decrement: 1,
            },
          },
        });
      });

      //update ticket
      const allWaitings = await waitingService.getWaitingByScheduleIdService(
        scheduleId
      );

      //return ticket back to user
      for (let i = 0; i < allWaitings.length; i++) {
        const getTicketsbyUserId = await prisma.ticket.findUnique({
          where: { userId: allWaitings[i].user.id },
        });

        // update ticket for waiting user:
        await prisma.ticket.update({
          where: { userId: allWaitings[i]?.user?.id },
          data: {
            remainTicket: getTicketsbyUserId!?.remainTicket + 1,
            ticketLimitInhand:
              getTicketsbyUserId!?.ticketLimitInhand <= 0
                ? 0
                : getTicketsbyUserId!?.ticketLimitInhand - 1,
          },
        });
      }

      // delete all waiting user after validate:
      await waitingService.deleteWaitingByScheduleId(scheduleId);

      // const send = await mailConfirmSchedule(schedule, books);

      //returnIntoList
      if (destination === "kirirom") {
        listUsers?.map((userInfo) => {
          userInKrr.push(userInfo.user.email);
        });
      } else {
        listUsers?.map((userInfo) => {
          userOutKrr.push(userInfo.user.email);
        });
      }
    }

    // Update the schedule
    await prisma.schedule.update({
      where: {
        id: scheduleId,
      },
      data: {
        enable: !confirm,
      },
    });

    // Check if a bus is associated with the schedule
    const scheduleIncludeBus = await prisma.schedule.findUnique({
      where: {
        id: scheduleId,
      },
      include: {
        bus: true, // Include the bus in the result
      },
    });

    // If a bus is associated, update the bus
    if (scheduleIncludeBus && scheduleIncludeBus.bus) {
      await prisma.bus.update({
        where: {
          id: scheduleIncludeBus.bus.id,
        },
        data: {
          enable: !confirm,
        },
      });
    }

    // for laundry:
    // suspend or unsuspend user for laundry start working
    const targetDate = schedule?.date || new Date();
    const targetTime = schedule?.departure.departureTime || new Date();

    // find current date:
    const currentDateTime = Date.now(); // Get current time in milliseconds
    const utcDateTime = new Date(currentDateTime);

    // convert current time to UTC time in Cambodia
    const cambodiaDateTime = new Date(
      utcDateTime.getTime() + 7 * 60 * 60 * 1000
    ); // add 7hours to UTC time

    // date of target
    const targetDateTime =
      confirm && confirm === true
        ? combineDateTime(targetDate, targetTime)
        : cambodiaDateTime;

    // Calculate the delay until the targetDate
    const delay =
      confirm === false
        ? 0
        : targetDateTime.getTime() - cambodiaDateTime.getTime();

    // Ensure delay is positive
    const adjustedDelay = delay < 0 ? 0 : delay;
    console.log(
      "Suspend/unsuspend user for laundry Delay until targetDate:",
      adjustedDelay,
      "ms"
    );

    setTimeout(async () => {
      console.log("Suspend/unsuspend work ....");
      await updateUserStatusLaundry(userInKrr, userOutKrr);
    }, adjustedDelay);

    return schedule;
  } catch (error) {
    console.log("Error: " + error);
  }
}

// get schedule by month
async function getScheduleByYearAndMonthService(
  startDate: Date,
  endDate: Date
) {
  const schedule = await prisma.schedule.findMany({
    where: {
      date: {
        gte: startDate,
        lte: endDate,
      },
    },
  });
  return schedule;
}
async function getPaginatedScheduleByYearAndMonthService(
  startDate: Date,
  endDate: Date,
  limit: number,
  page: number
) {
  const res = await prisma.schedule.findMany({
    where: {
      date: {
        gte: startDate,
        lte: endDate,
      },
    },
  });
  const total = await prisma.schedule.count({
    where: {
      date: {
        gte: startDate,
        lte: endDate,
      },
    },
  });
  const pages = Math.ceil(total / limit);
  if (page > pages && pages !== 0)
    throw new CustomError(400, `Sorry maximum page is ${pages}`);

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

async function getScheduleByDateService(date: string) {
  console.log("Date:", new Date(date));

  const schedule = await prisma.schedule.findMany({
    where: {
      date: new Date(date),
      enable: true,
    },
    select: selectDefault,
  });
  return schedule;
}

async function getAllScheduleByStatusService(enable: boolean) {
  const date = new Date();
  const schedules = await prisma.schedule.findMany({
    where: {
      enable: enable,
    },
    select: selectDefault,
  });
  const filterAvailableSchedule = schedules.filter(
    (sch: any) => sch.date >= date
  );
  return filterAvailableSchedule;
}
async function getPaginatedAllScheduleByStatusService(
  enable: boolean,
  limit: number,
  page: number
) {
  const date = new Date();
  const schedules = await prisma.schedule.findMany({
    take: limit,
    skip: (page - 1) * limit,
    where: {
      enable: enable, // Replace 'enable' with your actual condition.
      date: {
        gte: date, // Use "greater than or equal to" (gte) to compare dates.
      },
    },
    select: selectDefault,
  });

  const total = await prisma.schedule.count({
    where: {
      enable: enable, // Replace 'enable' with your actual condition.
      date: {
        gte: date, // Use "greater than or equal to" (gte) to compare dates.
      },
    },
  });
  const pages = Math.ceil(total / limit);
  if (page > pages && pages !== 0)
    throw new CustomError(400, `Sorry maximum page is ${pages}`);

  return {
    pagination: {
      totalData: total,
      totalPages: pages,
      dataPerPage: limit,
      currentPage: page,
    },
    data: schedules,
  };
}

export default {
  getAllScheduleByStatusService,
  getPaginatedAllScheduleByStatusService,
  getScheduleByDateService,
  batchCreateScheduleService,
  getAllScheduleService,
  getAllSchedulePaginatedService,
  getScheduleByIdService,
  getScheduleByYearAndMonthService,
  getPaginatedScheduleByYearAndMonthService,
  createScheduleService,
  deleteScheduleByIdService,
  updateScheduleByIdService,
  confirmSchedule,
  blockSeatService,
  unblockSeatService,
  updateBlockSeatInfoService,
};

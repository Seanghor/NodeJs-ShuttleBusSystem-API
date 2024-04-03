import scheduleService from "../routes/schedule/schedule.service";
const cron = require("node-cron");
import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

export const autoValidateSchedule = async () => {
  const currentDateUTC = new Date();
  // Adjusting for Cambodia time (UTC+7)
  const cambodiaDateUTC = new Date(
    currentDateUTC.getTime() + 7 * 60 * 60 * 1000
  );

  // Calculating the date 5 days ahead
  let numberOfDaysAhead = 5; // example: schedule day 2024-01-04, today is 2024-01-01, so all schedule where date < 2024-01-06 will be validated
  const date5DaysAhead = new Date(
    cambodiaDateUTC.getTime() + numberOfDaysAhead * 24 * 60 * 60 * 1000
  ); // Adding 5 days

  console.log("-------------- Autovalidate started --------------");
  // console.log("Cambodia Date in UTC:", cambodiaDateUTC.toISOString());
  // console.log("Date 5 Days Ahead in UTC:", date5DaysAhead.toISOString());

  cron.schedule("0 17 * * 4", async () => {
    // for Every Thursday at 5:00 PM
    console.log(
      "----------------> Today is validating day <----------------",
      cambodiaDateUTC
    );

    //   // Fetch schedules from database where date is earlier than 5 days ahead
    const schedules = await prisma.schedule.findMany({
      where: {
        AND: [
          {
            date: {
              lt: date5DaysAhead,
            },
          },
          {
            enable: true,
          },
        ],
      },
    });

    for (let sched of schedules) {
      try {
        await scheduleService.confirmSchedule(sched.id, true);
      } catch (error) {
        console.error("Error confirming schedule:", error);
        // Handle the error appropriately
      }
    }
  });
};

// for testing
export const schedules = async () => {
  const currentDateUTC = new Date();
  // Adjusting for Cambodia time (UTC+7)
  const cambodiaDateUTC = new Date(
    currentDateUTC.getTime() + 7 * 60 * 60 * 1000
  );

  // Calculating the date 5 days ahead
  const date5DaysAhead = new Date(
    cambodiaDateUTC.getTime() + 24 * 24 * 60 * 60 * 1000
  ); // Adding 5 days

  console.log("-------------- Current Date --------------");
  console.log("Cambodia Date in UTC:", cambodiaDateUTC.toISOString());
  console.log("Date 5 Days Ahead in UTC:", date5DaysAhead.toISOString());

  // Fetch schedules from database where date is earlier than 5 days ahead
  const schedules = await prisma.schedule.findMany({
    where: {
      AND: [
        {
          date: {
            lt: date5DaysAhead,
          },
        },
        {
          enable: true,
        },
      ],
    },
  });

  for (let sched of schedules) {
    try {
      await scheduleService.confirmSchedule(sched.id, true);
    } catch (error) {
      console.error("Error confirming schedule:", error);
      // Handle the error appropriately
    }
  }
};

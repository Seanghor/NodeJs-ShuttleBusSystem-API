import config from "../config/config";
import { CustomError } from "../handler/customError";
import { formatDateToCustomFormat, formatTimeWithAMPM } from "./formatingData";
import jwt from "./jwt-generate";
const path = require("path"); // Import the path module
const nodemailer = require("nodemailer");
const Email = require("email-templates");

export const mail = async (sendTo: string, name: string, password: string) => {
  let transporter = nodemailer.createTransport({
    host: "shuttlebus@kit.edu.kh",
    port: 465,
    secure: true,
    service: "gmail",
    auth: {
      user: config.MAILUSER,
      pass: config.MAILPASS,
    },
  });
  const email = new Email({
    views: { root: "./src/views", options: { extension: "ejs" } },
    message: {
      // from: "",
      from: `${config.MAILUSERNAME} <__>`,
    },
    iSsecure: true,
    preview: false,
    send: true,
    transport: transporter,
  });
  try {
    await email
      .send({
        template: "credential",
        message: {
          to: sendTo,
        },
        locals: {
          name: name,
          password: password,
          email: sendTo,
        },
      })
      .then(console.log(`Mail sent successfully to ${sendTo}`));
    return "mail";
  } catch (error) {
    throw new CustomError(500, "Error in sending mail");
  }
};

export const mailResetPassword = async (sendTo: string, name: string) => {
  try {
    let transporter = nodemailer.createTransport({
      host: "shuttlebus@kit.edu.kh",
      port: 587,
      secure: true,
      service: "gmail",
      pool: true,
      auth: {
        user: config.MAILUSER,
        pass: config.MAILPASS,
      },
    });

    const token = jwt.forgetPasswordToken(sendTo);

    const url = `${config.BASE}/user/request/reset-password/${token.forgetPasswordToken}`;
    const email = new Email({
      views: { root: "./src/views", options: { extension: "ejs" } },
      message: {
        from: `${config.MAILUSERNAME} <__>`,
      },
      iSsecure: true,
      preview: false,
      send: true,
      transport: transporter,
    });
    const send = await email
      .send({
        template: "resetpassword",
        message: {
          to: sendTo,
        },
        locals: {
          url: url,
          name: name,
        },
      })
      .then(console.log(`Mail sent successfully to ${sendTo}`))
      .catch();
    return send;
  } catch (error) {
    throw new CustomError(500, "Error in sending mail");
  }
};

export const mailConfirmSchedule = async (
  schedule: any,
  list_booking: any[]
) => {
  try {
    let transporter = nodemailer.createTransport({
      host: "shuttlebus@kit.edu.kh",
      service: "gmail",
      port: 465,
      secure: true,
      logger: true,
      debug: true,
      secureConnection: false,

      auth: {
        user: config.MAILUSER,
        pass: config.MAILPASS,
      },
      tls: {
        rejectUnauthorized: true,
      },
    });
    const email = new Email({
      views: {
        root: path.join(__dirname, "..", "views"), // Set the correct path to the views directory
        options: { extension: "ejs" },
      },
      message: {
        // from: myEmail,
        // from: `${name} <${myEmail}>`, // Corrected the email format
        // from: `Shuttle Bus KIT <__>`, // Corrected the email format
        from: `${config.MAILUSERNAME} <__>`, // Corrected the email format
      },

      ISsecure: true,
      preview: false,
      send: true,
      transport: transporter,
    });

    const emailPromises = list_booking.map(async (book: any) => {
      try {
        await email.send({
          template: "confirm_booking",
          message: {
            to: book.user.email,
          },
          locals: {
            booking_date: formatDateToCustomFormat(book?.createdAt),
            departure: `${schedule.departure.from.mainLocationName} - ${schedule.departure.destination.mainLocationName}`,
            departureDate: formatDateToCustomFormat(schedule?.date),
            departureTime: formatTimeWithAMPM(
              schedule?.departure?.departureTime
            ),
            name: book.user.username,
            sbsTeam: config.MAILUSER,
            pickup: schedule.departure?.pickupLocation?.subLocationName,
            drop: schedule.departure.dropLocation.subLocationName,
          },
        });

        console.log(`Mail sent successfully to ${book.user.email}`);
      } catch (error: any) {
        console.error(
          `Error sending mail to ${book.user.email}: ${error.message}`
        );
      }
    });

    // Wait for all email sending promises to complete
    await Promise.all(emailPromises);

    return "Mail sending process completed";
  } catch (error: any) {
    throw new CustomError(500, "Error in sending mail");
  }
};

export const mailSuspendUser = async (userEmail: string, name: string) => {
  try {
    console.log("path:", path.join(__dirname, "..", "views"));
    let transporter = nodemailer.createTransport({
      host: "shuttlebus@kit.edu.kh",
      service: "gmail",
      port: 465,
      secure: true,
      logger: true,
      debug: true,
      secureConnection: false,

      auth: {
        user: config.MAILUSER,
        pass: config.MAILPASS,
      },
      tls: {
        rejectUnauthorized: true,
      },
    });
    const email = new Email({
      views: {
        root: path.join(__dirname, "..", "views"), // Set the correct path to the views directory
        options: { extension: "ejs" },
      },
      message: {
        // from: myEmail,
        // from: `${name} <${myEmail}>`, // Corrected the email format
        from: `${config.MAILUSERNAME} <__>`, // Corrected the email format
      },

      ISsecure: true,
      preview: false,
      send: true,
      transport: transporter,
    });

    await email
      .send({
        // Await the email sending
        template: "suspend_mail",
        message: {
          to: userEmail,
        },
        locals: {
          username: name,
          sbsTeam: config.MAILUSER,
        },
      })
      .then(console.log(`Mail sent successfully to ${userEmail}`));
  } catch (error: any) {
    throw new CustomError(500, "Error in sending mail");
  }
};

export const mailUnSuspendUser = async (userEmail: string, name: string) => {
  try {
    console.log("path:", path.join(__dirname, "..", "views"));
    let transporter = nodemailer.createTransport({
      host: "shuttlebus@kit.edu.kh",
      service: "gmail",
      port: 465,
      secure: true,
      logger: true,
      debug: true,
      secureConnection: false,

      auth: {
        user: config.MAILUSER,
        pass: config.MAILPASS,
      },
      tls: {
        rejectUnauthorized: true,
      },
    });
    const email = new Email({
      views: {
        root: path.join(__dirname, "..", "views"), // Set the correct path to the views directory
        options: { extension: "ejs" },
      },
      message: {
        // from: myEmail,
        // from: `${name} <${myEmail}>`, // Corrected the email format
        // from: `Shuttle Bus KIT <__>`, // Corrected the email format
        from: `${config.MAILUSERNAME} <__>`, // Corrected the email format
      },

      ISsecure: true,
      preview: false,
      send: true,
      transport: transporter,
    });

    await email
      .send({
        // Await the email sending
        template: "unsuspend_mail",
        message: {
          to: userEmail,
        },
        locals: {
          username: name,
          sbsTeam: config.MAILUSER,
        },
      })
      .then(console.log(`Mail sent successfully to ${userEmail}`));
  } catch (error: any) {
    throw new CustomError(500, "Error in sending mail");
  }
};

export const asyncronusMail = async (userEmail: string, name: string) => {
  try {
    console.log("path:", path.join(__dirname, "..", "views"));
    let transporter = nodemailer.createTransport({
      host: "shuttlebus@kit.edu.kh",
      service: "gmail",
      port: 465,
      secure: true,
      logger: true,
      debug: true,
      secureConnection: false,

      auth: {
        user: config.MAILUSER,
        pass: config.MAILPASS,
      },
      tls: {
        rejectUnauthorized: true,
      },
    });
    const email = new Email({
      views: {
        root: path.join(__dirname, "..", "views"), // Set the correct path to the views directory
        options: { extension: "ejs" },
      },
      message: {
        // from: myEmail,
        // from: `${name} <${myEmail}>`, // Corrected the email format
        // from: `Shuttle Bus KIT <__>`, // Corrected the email format
        from: `${config.MAILUSERNAME} <__>`, // Corrected the email format
      },

      ISsecure: true,
      preview: false,
      send: true,
      transport: transporter,
    });

    await email
      .send({
        // Await the email sending
        template: "wishing_mail",
        message: {
          to: userEmail,
        },
        locals: {
          username: name,
          sbsTeam: config.MAILUSER,
        },
      })
      .then(console.log(`Mail sent successfully to ${userEmail}`));
  } catch (error: any) {
    throw new CustomError(500, "Error in sending mail");
  }
};

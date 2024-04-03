export function formatTimeWithAMPM(timestamp: Date) {
  const date = new Date(timestamp);
  let hours = date.getUTCHours();
  const minutes = date.getUTCMinutes().toString().padStart(2, "0");
  const ampm = hours >= 12 ? "PM" : "AM";

  // Convert hours to 12-hour format
  hours = hours % 12;
  hours = hours ? hours : 12;

  return `${hours}:${minutes} ${ampm}`;
}

// export function getCurrentCambodiaDate() {
//   const currentDateUTC = new Date();
//   const cambodiaDateUTC = new Date(
//     currentDateUTC.getTime() + 7 * 60 * 60 * 1000
//   );

//   const formattedDate = `${cambodiaDateUTC.getDate() }-${
//     cambodiaDateUTC.getMonth() + 1
//   }-${cambodiaDateUTC.getFullYear()}`;
//   return formattedDate;
// }
export function areStringsSameIgnoringSpaces(str1: string, str2: string) {
  // Remove all spaces from both strings
  const normalizedStr1 = str1.replace(/\s+/g, "").toLowerCase();
  const normalizedStr2 = str2.replace(/\s+/g, "").toLowerCase();

  // Compare the normalized strings
  return normalizedStr1 === normalizedStr2;
}
export function getCurrentCambodiaDate() {
  // Create a date object for the current time
  const currentDate = new Date();

  // Format the date in Cambodia's timezone
  const formatter = new Intl.DateTimeFormat("en-GB", {
    day: "2-digit",
    month: "short",
    year: "numeric",
    timeZone: "Asia/Phnom_Penh",
  });

  // Format the current date in the specified format and timezone
  const cambodiaDate = formatter.format(currentDate);

  return cambodiaDate;
}

export function getCurrentDateTimeCambodia() {
  const currentDateUTC = new Date();
  // Adjusting for Cambodia time (UTC+7)
  const cambodiaDateUTC = new Date(
    currentDateUTC.getTime() + 7 * 60 * 60 * 1000
  );
  const currentDate = getCurrentCambodiaDate();
  const camHour = formatTimeWithAMPM(cambodiaDateUTC);
  const createAt = `${currentDate} ${camHour}`;
  return createAt;
}

export function formatDateToCustomFormat(dateString: Date) {
  const dateObj = new Date(dateString);

  const months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];

  const formattedDate = `${dateObj.getDate()}-${
    months[dateObj.getMonth()]
  }-${dateObj.getFullYear()}`;
  return formattedDate;
}

export function getTime(dateTimeString: Date) {
  // Extract hours, minutes, and seconds
  const hours = dateTimeString.getUTCHours();
  const minutes = dateTimeString.getUTCMinutes();
  const seconds = dateTimeString.getUTCSeconds();

  // Format the time
  const formattedTime = `${hours}:${minutes}:${seconds}`;
  return formattedTime;
}

export function combineDateTime(dateTimeString: Date, timeString: Date) {
  // const date1 = new Date(dateString1);
  // const date2 = new Date(dateString2);

  // Extract date from the first string
  const year = dateTimeString.getUTCFullYear();
  const month = dateTimeString.getUTCMonth();
  const day = dateTimeString.getUTCDate();

  // Extract time from the second string
  const hours = timeString.getUTCHours();
  const minutes = timeString.getUTCMinutes();
  const seconds = timeString.getUTCSeconds();

  // Create a new Date object with the date from the first string and time from the second string
  const combinedDateTime = new Date(
    Date.UTC(year, month, day, hours, minutes, seconds)
  );
  return combinedDateTime;
}

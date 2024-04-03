import { DepartmentEnum, GenderEnum, RoleEnum } from "@prisma/client";
import fs from "fs";
// const path = require('path')
import path from "path";
import utils from "util";
import puppeteer from "puppeteer";
import hb from "handlebars";
const readFile = utils.promisify(fs.readFile);
const templateDir = path.resolve(__dirname, "../views/pdfTemplate");

async function getTemplateHtml(templateName: string) {
  try {
    const templatePath = path.resolve(templateName);
    return await readFile(templatePath, "utf8");
  } catch (err) {
    throw new Error("Could not load html template");
  }
}
export interface bookingProps {
  index: number;
  username: string;
  gender: string | GenderEnum;
  batch: string;
  role: string | RoleEnum | null;
  departureDate: string | Date;
  from_to: string;
  phone: string;
  departureTime: string | Date | undefined;
}
export interface bookingPropsOfMutipleSchedule {
  direction: string;
  // departureDate: string;
  data: bookingProps[];
}
async function downloadBookingOfMutipleScheduleToPDF(
  dataFromDb: bookingPropsOfMutipleSchedule[],
  dateStr: string,
  createAt: string
) {
  {
    const templatePath = path.resolve(templateDir, "multiple_schedule.html");
    const templateHtml = await getTemplateHtml(templatePath);
    const template = hb.compile(templateHtml, { strict: true });

    const html = template({ dataFromDb, dateStr, createAt });

    const browser = await puppeteer.launch({
      args: ["--no-sandbox", "--disable-setuid-sandbox"],
      headless: true,
    });
    const page = await browser.newPage();
    await page.setContent(html);

    const pdfBuffer = await page.pdf({
      // format: 'A4',
      width: "822px",
      printBackground: true,
    });
    await browser.close();
    return pdfBuffer;
  }
}

export interface bookingProps {
  index: number;
  username: string;
  gender: string | GenderEnum;
  batch: string;
  role: string | RoleEnum | null;
  departureDate: string | Date;
  from_to: string;
  phone: string;
  departureTime: string | Date | undefined;
}
async function downloadBookingOfScheduleToPDF(
  dataFromDb: bookingProps[],
  direction: string,
  dateStr: string,
  createAt: string
) {
  const templatePath = path.resolve(templateDir, "single_schedule.html");
  const templateHtml = await getTemplateHtml(templatePath);
  const template = hb.compile(templateHtml, { strict: true });
  const html = template({ dataFromDb, direction, dateStr, createAt });

  const browser = await puppeteer.launch({
    args: ["--no-sandbox", "--disable-setuid-sandbox"],
    headless: true,
  });
  const page = await browser.newPage();
  await page.setContent(html);

  const pdfBuffer = await page.pdf({
    // format: 'A4',
    width: "822px",
    printBackground: true,
  });
  await browser.close();
  return pdfBuffer;
}
// --------------------------------- User ---------------------------------
interface userProps {
  index: number;
  username: string;
  status: string;
  role: string | RoleEnum;
  gender: string | GenderEnum;
  department: string;
  email: string;
  phone: string;
}
async function downloadToPDF(
  dataFromDb: userProps[],
  listName: string,
  createAt: string
) {
  const templatePath = path.resolve(templateDir, "user_template.html");
  const templateHtml = await getTemplateHtml(templatePath);
  const template = hb.compile(templateHtml, { strict: true });
  const html = template({ dataFromDb, listName, createAt });

  const browser = await puppeteer.launch({
    args: ["--no-sandbox", "--disable-setuid-sandbox"],
    headless: true,
  });
  const page = await browser.newPage();
  await page.setContent(html);

  const pdfBuffer = await page.pdf({
    // format: 'A4',
    width: "822px",
    printBackground: true,
  });
  await browser.close();
  return pdfBuffer;
}

// ------------------ Staff ------------------
interface staffProps {
  index: number;
  username: string;
  status: string;
  gender: string | GenderEnum;
  email: string;
  department: string;
  phone: string;
}
async function downloadStaffToPDF(
  dataFromDb: staffProps[],
  listName: string,
  createAt: string
) {
  const templatePath = path.resolve(templateDir, "staff_template.html");
  const templateHtml = await getTemplateHtml(templatePath);
  const template = hb.compile(templateHtml, { strict: true });
  const html = template({ dataFromDb, listName, createAt });

  const browser = await puppeteer.launch({
    args: ["--no-sandbox", "--disable-setuid-sandbox"],
    headless: true,
  });
  const page = await browser.newPage();
  await page.setContent(html);

  const pdfBuffer = await page.pdf({
    // format: 'A4',
    width: "822px",
    printBackground: true,
  });
  await browser.close();
  return pdfBuffer;
}

// ---------------- Student ----------------
interface studentProps {
  index: number;
  username: string;
  status: string;
  gender: string | GenderEnum;
  department: string | DepartmentEnum;
  email: string;
  phone: string;
  role: string;
}
async function downloadStudentToPDF(
  dataFromDb: studentProps[],
  listName: string,
  createAt: string
) {
  const templatePath = path.resolve(templateDir, "student_template.html");
  const templateHtml = await getTemplateHtml(templatePath);
  const template = hb.compile(templateHtml, { strict: true });
  const html = template({ dataFromDb, listName, createAt });

  const browser = await puppeteer.launch({
    args: ["--no-sandbox", "--disable-setuid-sandbox"],
    headless: true,
  });
  const page = await browser.newPage();
  await page.setContent(html);

  const pdfBuffer = await page.pdf({
    // format: 'A4',
    width: "822px",
    printBackground: true,
  });
  await browser.close();
  return pdfBuffer;
}

export default {
  downloadBookingOfMutipleScheduleToPDF,
  downloadBookingOfScheduleToPDF,
  downloadToPDF,
  downloadStaffToPDF,
  downloadStudentToPDF,
};

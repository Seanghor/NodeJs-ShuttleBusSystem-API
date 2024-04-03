const fs = require("fs");
const path = require("path");
const utils = require("util");
const puppeteer = require("puppeteer");
const hb = require("handlebars");
const readFile = utils.promisify(fs.readFile);
// import ejs from 'ejs'

async function getTemplateHtml() {
  try {
    const invoicePath = path.resolve("src/views/pdfTemplate/invoice.html");
    return await readFile(invoicePath, "utf8");
  } catch (err) {
    throw new Error("Could not load html template");
  }
}

export async function generatePdf(data: any) {
  const templateHtml = await getTemplateHtml();
  const template = hb.compile(templateHtml, { strict: true });
  const html = template(data);
  // const browser = await puppeteer.launch();
  const browser = await puppeteer.launch({
    args: ["--no-sandbox", "--disable-setuid-sandbox"],
    headless: true,
  });
  const page = await browser.newPage();
  await page.setContent(html);
  // Instead of saving the file, we'll directly return the PDF as a buffer
  const pdfBuffer = await page.pdf({ format: "A4" });
  await browser.close();
  return pdfBuffer;
}

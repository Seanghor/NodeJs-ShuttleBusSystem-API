import config from "../config/config";
const axios = require("axios");

async function updateUserStatusLaundry(
  userIn: (string | null)[],
  userOut: (string | null)[]
): Promise<void> {
  const url = config.LAUNDRY;
  try {
    console.log(
      "---------------------- Laudry -------------------------------"
    );

    // add body fields
    const response = await axios.post(
      url,
      {
        Inkrr: userIn,
        Outkrr: userOut,
      },
      {
        headers: {
          "Content-Type": "application/json", // Set the content type to JSON
        },
      }
    );
    console.log(
      `POST request to ${url} successful. Response data:`,
      response.data
    );
  } catch (error) {
    console.error(`Error sending POST request to laundry ${url}:`, error);
  }
}
export default updateUserStatusLaundry;

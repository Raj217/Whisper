import { toIST } from "../../utils/time.service.js";

export const welcome = async () => {
  const { VERSION } = process.env;

  const welcomeMessage = {
    message: `
    Welcome to whisper API v-${VERSION}
    Current date - ${toIST(new Date())}
    `,
  };
  return welcomeMessage;
};

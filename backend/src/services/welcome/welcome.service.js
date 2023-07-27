import { toIST } from "../../utils/time.service.js";
import pkj from "./../../../package.json" assert { type: "json" };

export const welcome = async () => {
  const welcomeMessage = {
    message: `
    Welcome to whisper API v-${pkj.version}
    Current date - ${toIST(new Date())}
    `,
  };
  return welcomeMessage;
};

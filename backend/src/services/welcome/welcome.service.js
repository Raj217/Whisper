export const welcome = async () => {
  const { VERSION } = process.env;

  const welcomeMessage = {
    message: `
    Welcome to whisper API v-${VERSION}
    Current date - ${new Date()}
    `,
  };
  return welcomeMessage;
};

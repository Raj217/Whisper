export const logger = (req, res, next) => {
  console.log(`Request Type: ${req.method}`);
  console.log(`Route: ${ req.url}`);
  next();
};

/**
 * Returns a random time between start and end in minutes
 */
export const generateRandomTime = (start, end) => {
  end *= 1000 * 60;
  start *= 1000 * 60;
  return Math.floor(Math.random() * (end - start + 1)) + start;
};

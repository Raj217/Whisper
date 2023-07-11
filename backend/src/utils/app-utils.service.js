/**
 * Returns a random time between start and end in minutes
 */
export const getRandomTime = (start, end) => {
  end *= 1000;
  start *= 1000;
  return Math.floor(Math.random() * (end - start + 1)) + start;
};

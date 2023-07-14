export const toIST = (date) => {
  return Date(date.toISOString() + " GMT+5:30");
};

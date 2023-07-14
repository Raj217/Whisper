export const toIST = (date) => {
  const currTime = new Date();
  const currentOffset = currTime.getTimezoneOffset();
  const ISTOffset = 330; // IST offset UTC +5:30
  const ISTTime = new Date(
    date.getTime() + (ISTOffset + currentOffset) * 60000
  );
  return ISTTime;
};

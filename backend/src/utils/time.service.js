export const toIST = (date) => {
  const currentOffset = date.getTimezoneOffset();
  const ISTOffset = 330; // IST offset UTC +5:30
  const ISTTime = new Date(
    currentTime.getTime() + (ISTOffset + currentOffset) * 60000
  );
  return ISTTime;
};

console.logCopy = console.log.bind(console);

console.log = function (data) {
  const currentTime = new Date();
  const currentOffset = currentTime.getTimezoneOffset();
  const ISTOffset = 330; // IST offset UTC +5:30
  const ISTTime = new Date(
    currentTime.getTime() + (ISTOffset + currentOffset) * 60000
  );
  var currDate = "[" + ISTTime + "]";
  this.logCopy(currDate, data);
};

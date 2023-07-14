import { toIST } from "../utils/time.service";

console.logCopy = console.log.bind(console);

console.log = function (data) {
  var currDate = "[" + toIST(new Date()) + "]";
  this.logCopy(currDate, data);
};

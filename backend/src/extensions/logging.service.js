import { toIST } from "../utils/time.service.js";

console.logCopy = console.log.bind(console);

console.log = function (data) {
  var currDate = "[" + toIST(new Date()) + "]";
  this.logCopy(currDate, data);
};

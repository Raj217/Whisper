export const stopChain = async (timer) => {
  if (timer.val !== null) {
    clearTimeout(timer.val);
    timer.val = null;
    timer.nextScheduled = null;
    return { message: "Scraping stopped..." };
  } else {
    return { message: "Scraping was already stopped..." };
  }
};

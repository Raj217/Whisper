import ViewTransaction from "../../../models/transactions/view-transaction-model.js";
import DownloadTransaction from "../../../models/transactions/download-transaction-model.js";
import { ImagePurpose } from "../../../models/constants";

export const addTransaction = async (purpose, uid, imageID) => {
  var transaction;
  switch (purpose) {
    case ImagePurpose.view:
      transaction = new ViewTransaction();
      break;
    case ImagePurpose.download:
      transaction = new DownloadTransaction();
      break;
  }
  if (transaction) {
    await transaction.create(uid, imageID);
  }
};

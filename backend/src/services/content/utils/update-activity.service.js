import ViewTransaction from "../../../models/transactions/view-transaction-model.js";
import DownloadTransaction from "../../../models/transactions/download-transaction-model.js";
import { ImagePurpose } from "../../../models/constants.js";
import User from "../../../models/user-model.js";

export const updateActivity = async (purpose, email, imageID, lastViewed) => {
  var transaction;
  switch (purpose) {
    case ImagePurpose.thumbnail:
      User.updateLastViewed(lastViewed, email);
      break;
    case ImagePurpose.view:
      transaction = new ViewTransaction();
      break;
    case ImagePurpose.download:
      transaction = new DownloadTransaction();
      break;
  }
  if (transaction) {
    await transaction.create(email, imageID);
  }
};

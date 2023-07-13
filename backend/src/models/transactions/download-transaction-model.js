import Transaction from "./transaction-model.service.js";

class DownloadTransaction extends Transaction {
  constructor() {
    super();
    this.collectionName = "download-transactions";
  }
}

export default DownloadTransaction;

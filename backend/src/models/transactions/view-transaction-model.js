import Transaction from "./transaction-model.service.js";

class ViewTransaction extends Transaction {
  constructor() {
    super();
    this.collectionName = "view-transactions";
  }
}

export default ViewTransaction;

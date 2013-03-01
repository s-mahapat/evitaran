function JDSConstants(){
    this.monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

    // inward types
    this.INWARD_PURPOSE_NEW_SUBSCRIPTION = 1;
    this.INWARD_PURPOSE_RENEW_SUBSCRIPTION = 2;
    this.INWARD_PURPOSE_ADDRESS_CHANGE = 10;
    this.INWARD_PURPOSE_REQUEST_FOR_INVOICE = 4;
    this.INWARD_PURPOSE_MISSING_ISSUE = 5;
    this.INWARD_PURPOSE_PAYMENT = 3;

    //invoice types
    this.INVOICE_REQUEST_FOR_INVOICE = 1;
    this.INVOICE_OUTSTANDING_PAYMENT_INVOICE = 2;
    this.INVOICE_UPCOMING_YEAR_INVOICE = 3;

}



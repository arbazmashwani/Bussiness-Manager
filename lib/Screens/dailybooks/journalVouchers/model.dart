class jouranl_voucher_h_model {
  String? entryNo;
  String? voucherNo;
  String? dated;
  String? particulars;
  int? amount;
  int? convRate;
  String? jvBook;
  String? jvNature;

  jouranl_voucher_h_model(
      {this.entryNo,
      this.voucherNo,
      this.dated,
      this.particulars,
      this.amount,
      this.convRate,
      this.jvBook,
      this.jvNature});

  jouranl_voucher_h_model.fromJson(Map<String, dynamic> json) {
    entryNo = json['EntryNo'];
    voucherNo = json['VoucherNo'];
    dated = json['Dated'];
    particulars = json['Particulars'];
    amount = json['Amount'];
    convRate = json['ConvRate'];
    jvBook = json['JvBook'];
    jvNature = json['JvNature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EntryNo'] = entryNo;
    data['VoucherNo'] = voucherNo;
    data['Dated'] = dated;
    data['Particulars'] = particulars;
    data['Amount'] = amount;
    data['ConvRate'] = convRate;
    data['JvBook'] = jvBook;
    data['JvNature'] = jvNature;
    return data;
  }
}

class jouranl_voucher_d_model {
  String? entryNo;
  String? voucherNo;

  String? acCode;
  String? particulars;
  int? debit;
  int? credit;

  jouranl_voucher_d_model(
      {this.entryNo,
      this.voucherNo,
      this.acCode,
      this.particulars,
      this.debit,
      this.credit});

  jouranl_voucher_d_model.fromJson(Map<String, dynamic> json) {
    entryNo = json['EntryNo'];
    voucherNo = json['VoucherNo'];

    acCode = json['AcCode'];
    particulars = json['Particulars'];
    debit = json['Debit'];
    credit = json['Credit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EntryNo'] = entryNo;
    data['VoucherNo'] = voucherNo;

    data['AcCode'] = acCode;
    data['Particulars'] = particulars;
    data['Debit'] = debit;
    data['Credit'] = credit;
    return data;
  }
}

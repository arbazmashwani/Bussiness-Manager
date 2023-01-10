class Transfers_H_model {
  String? entryNo;
  String? transNo;
  String? dated;
  String? wHFrom;
  String? wHTo;
  String? notes;
  String? Whfromname;
  String? whToname;

  Transfers_H_model(
      {this.entryNo,
      this.transNo,
      this.dated,
      this.wHFrom,
      this.wHTo,
      this.Whfromname,
      this.whToname,
      this.notes});

  Transfers_H_model.fromJson(Map<String, dynamic> json) {
    entryNo = json['EntryNo'];
    transNo = json['TransNo'];
    dated = json['Dated'];
    wHFrom = json['WH_From'];
    wHTo = json['WH_To'];
    notes = json['Notes'];
    Whfromname = json['Whfrom'];
    whToname = json['WhTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EntryNo'] = entryNo;
    data['TransNo'] = transNo;
    data['Dated'] = dated;
    data['WH_From'] = wHFrom;
    data['WH_To'] = wHTo;
    data['Notes'] = notes;
    data['Whfrom'] = Whfromname;
    data['WhTo'] = whToname;
    return data;
  }
}

class Transfers_D_model {
  String? entryNo;
  String? transNo;
  String? iCode;
  String? particulars;
  int? qty;

  Transfers_D_model(
      {this.entryNo, this.transNo, this.iCode, this.particulars, this.qty});

  Transfers_D_model.fromJson(Map<String, dynamic> json) {
    entryNo = json['EntryNo'];
    transNo = json['TransNo'];
    iCode = json['ICode'];
    particulars = json['Particulars'];
    qty = json['Qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EntryNo'] = entryNo;
    data['TransNo'] = transNo;
    data['ICode'] = iCode;
    data['Particulars'] = particulars;
    data['Qty'] = qty;
    return data;
  }
}

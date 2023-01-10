class account_manager_model {
  String? acCode;
  String? typeCode;
  String? acName;
  String? opDate;
  int? opBalance;
  int? balance;
  int? prevBal;
  int? convRate;

  account_manager_model(
      {this.acCode,
      this.typeCode,
      this.acName,
      this.opDate,
      this.opBalance,
      this.balance,
      this.prevBal,
      this.convRate});

  account_manager_model.fromJson(Map<String, dynamic> json) {
    acCode = json['AcCode'];
    typeCode = json['TypeCode'];
    acName = json['AcName'];
    opDate = json['OpDate'];
    opBalance = json['OpBalance'];
    balance = json['Balance'];
    prevBal = json['PrevBal'];
    convRate = json['ConvRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AcCode'] = acCode;
    data['TypeCode'] = typeCode;
    data['AcName'] = acName;
    data['OpDate'] = opDate;
    data['OpBalance'] = opBalance;
    data['Balance'] = balance;
    data['PrevBal'] = prevBal;
    data['ConvRate'] = convRate;
    return data;
  }
}

class AcTypeModel {
  String? typeCode;
  String? acType;

  AcTypeModel({this.typeCode, this.acType});

  AcTypeModel.fromJson(Map<String, dynamic> json) {
    typeCode = json['TypeCode'];
    acType = json['AcType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TypeCode'] = typeCode;
    data['AcType'] = acType;
    return data;
  }
}

class details_model {
  String? name;
  String? acCode;
  String? address1;
  String? address2;
  String? city;
  String? telephone;
  String? fax;
  String? contact;
  int? credit;
  String? remarks;
  String? saleMan;

  details_model(
      {this.name,
      this.acCode,
      this.address1,
      this.address2,
      this.city,
      this.telephone,
      this.fax,
      this.contact,
      this.credit,
      this.remarks,
      this.saleMan});

  details_model.fromJson(Map<String, dynamic> json) {
    name = json['AcName'];
    acCode = json['AcCode'];
    address1 = json['Address1'];
    address2 = json['Address2'];
    city = json['City'];
    telephone = json['Telephone'];
    fax = json['Fax'];
    contact = json['Contact'];
    credit = json['Credit'];
    remarks = json['Remarks'];
    saleMan = json['SaleMan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AcName'] = name;
    data['AcCode'] = acCode;
    data['Address1'] = address1;
    data['Address2'] = address2;
    data['City'] = city;
    data['Telephone'] = telephone;
    data['Fax'] = fax;
    data['Contact'] = contact;
    data['Credit'] = credit;
    data['Remarks'] = remarks;
    data['SaleMan'] = saleMan;
    return data;
  }
}

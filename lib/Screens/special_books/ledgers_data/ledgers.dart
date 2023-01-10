// To parse this JSON data, do
//
//     final ledgersModel = ledgersModelFromJson(jsonString);

import 'dart:convert';

List<LedgersModel> ledgersModelFromJson(String str) => List<LedgersModel>.from(
    json.decode(str).map((x) => LedgersModel.fromJson(x)));

String ledgersModelToJson(List<LedgersModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LedgersModel {
  LedgersModel({
    this.acCode,
    this.acName,
    this.balance,
    this.telephone,
  });

  String? acCode;
  String? acName;
  int? balance;
  String? telephone;

  factory LedgersModel.fromJson(Map<String, dynamic> json) => LedgersModel(
        acCode: json["AcCode"],
        acName: json["AcName"],
        balance: json["Balance"],
        telephone: json["Telephone"],
      );

  Map<String, dynamic> toJson() => {
        "AcCode": acCode,
        "AcName": acName,
        "Balance": balance,
        "Telephone": telephone ?? null,
      };
}

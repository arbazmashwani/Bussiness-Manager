// To parse this JSON data, do
//
//     final receiptModel = receiptModelFromJson(jsonString);

import 'dart:convert';

List<ReceiptModel> receiptModelFromJson(String str) => List<ReceiptModel>.from(
    json.decode(str).map((x) => ReceiptModel.fromJson(x)));

String receiptModelToJson(List<ReceiptModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReceiptModel {
  ReceiptModel(
      {this.dated,
      this.entryno,
      this.particulars,
      this.amount,
      this.recieptFrom,
      this.receiptAs,
      this.acCredited,
      this.acDebited,
      this.convRate});

  DateTime? dated;
  String? entryno;
  String? particulars;
  int? amount;
  String? acCredited;
  String? acDebited;
  int? convRate;
  String? recieptFrom;
  String? receiptAs;

  factory ReceiptModel.fromJson(Map<String, dynamic> json) => ReceiptModel(
      entryno: json['EntryNo'] ?? "",
      dated: DateTime.parse(json["dated"] ?? "2000-01-01"),
      particulars: json["Particulars"] ?? "",
      amount: json["Amount"] ?? "",
      recieptFrom: json["RecieptFrom"] ?? "",
      receiptAs: json["ReceiptAs"] ?? "",
      acCredited: json['AcCredited'] ?? "",
      acDebited: json['AcDebited'] ?? "",
      convRate: json['ConvRate'] ?? "");

  Map<String, dynamic> toJson() => {
        "EntryNo": entryno,
        "dated": dated,
        "Particulars": particulars,
        "Amount": amount,
        "RecieptFrom": recieptFrom,
        "ReceiptAs": receiptAs,
        "AcCredited": acCredited,
        "AcDebited": acDebited,
        "ConvRate": convRate,
      };
}

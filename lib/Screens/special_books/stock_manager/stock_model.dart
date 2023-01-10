// To parse this JSON data, do
//
//     final stockManagerModel = stockManagerModelFromJson(jsonString);

import 'dart:convert';

List<StockManagerModel> stockManagerModelFromJson(String str) =>
    List<StockManagerModel>.from(
        json.decode(str).map((x) => StockManagerModel.fromJson(x)));

String stockManagerModelToJson(List<StockManagerModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StockManagerModel {
  StockManagerModel({
    this.iCode,
    this.cCode,
    this.bCode,
    this.iDescription,
    this.iNick,
    this.packing,
    this.cost,
    this.rate,
    this.priceList,
    this.opQty,
    this.qtyMin,
    this.qtyMax,
    this.qtyIn,
    this.qtyOut,
    this.stockIn,
    this.stockOut,
  });

  String? iCode;
  String? cCode;
  String? bCode;
  String? iDescription;
  String? iNick;
  dynamic packing;
  int? cost;
  int? rate;
  double? priceList;
  int? opQty;
  int? qtyMin;
  int? qtyMax;
  int? qtyIn;
  int? qtyOut;
  int? stockIn;
  int? stockOut;

  factory StockManagerModel.fromJson(Map<String, dynamic> json) =>
      StockManagerModel(
        iCode: json["ICode"],
        cCode: json["CCode"],
        bCode: json["BCode"],
        iDescription: json["IDescription"],
        iNick: json["INick"],
        packing: json["Packing"],
        cost: json["Cost"],
        rate: json["Rate"],
        priceList: json["PriceList"].toDouble(),
        opQty: json["OpQty"],
        qtyMin: json["QtyMin"],
        qtyMax: json["QtyMax"],
        qtyIn: json["QtyIn"],
        qtyOut: json["QtyOut"],
        stockIn: json["StockIn"],
        stockOut: json["StockOut"],
      );

  Map<String, dynamic> toJson() => {
        "ICode": iCode,
        "CCode": cCode,
        "BCode": bCode,
        "IDescription": iDescription,
        "INick": iNick,
        "Packing": packing,
        "Cost": cost,
        "Rate": rate,
        "PriceList": priceList,
        "OpQty": opQty,
        "QtyMin": qtyMin,
        "QtyMax": qtyMax,
        "QtyIn": qtyIn,
        "QtyOut": qtyOut,
        "StockIn": stockIn,
        "StockOut": stockOut,
      };
}

//brands model
List<Brandsmodel> brandsmodelfromjson(String str) => List<Brandsmodel>.from(
    json.decode(str).map((x) => Brandsmodel.fromJson(x)));

String brandsmodeltojson(List<Brandsmodel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Brandsmodel {
  Brandsmodel({
    this.iCode,
    this.desc,
  });

  String? iCode;
  String? desc;

  factory Brandsmodel.fromJson(Map<String, dynamic> json) => Brandsmodel(
        iCode: json["BCode"],
        desc: json["BDescription"],
      );

  Map<String, dynamic> toJson() => {
        "BCode": iCode,
        "BDescription": desc,
      };
}

//category model
List<Categerysmodel> categerymodelfromjson(String str) =>
    List<Categerysmodel>.from(
        json.decode(str).map((x) => Categerysmodel.fromJson(x)));

String categerymodeltojson(List<Categerysmodel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categerysmodel {
  Categerysmodel({
    this.code,
    this.desc,
  });

  String? code;
  String? desc;

  factory Categerysmodel.fromJson(Map<String, dynamic> json) => Categerysmodel(
        code: json["CCode"],
        desc: json["CDescription"],
      );

  Map<String, dynamic> toJson() => {
        "CCode": code,
        "CDescription": desc,
      };
}

//warehouse model
List<warehousemodel> warehousefromjson(String str) => List<warehousemodel>.from(
    json.decode(str).map((x) => warehousemodel.fromJson(x)));

String warehousemodeltojson(List<warehousemodel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class warehousemodel {
  warehousemodel({
    this.code,
    this.desc,
  });

  String? code;
  String? desc;

  factory warehousemodel.fromJson(Map<String, dynamic> json) => warehousemodel(
        code: json["WHCode"],
        desc: json["WHDesc"],
      );

  Map<String, dynamic> toJson() => {
        "WHCode": code,
        "WHDesc": desc,
      };
}

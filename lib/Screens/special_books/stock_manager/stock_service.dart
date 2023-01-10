// ignore_for_file: null_check_always_fails

import 'dart:async';
import 'dart:convert' as convert;

import 'package:bm/Screens/special_books/stock_manager/stock_model.dart';
import 'package:bm/main.dart';

class StockService {
//fetch total today contractor from sql database

  Future<List<StockManagerModel>> getstockdata() async {
    var data = [];
    List<StockManagerModel> dataresult = [];
    try {
      final response = await apicall("select * from stock ");

      if (response.statusCode == 200) {
        data = convert.jsonDecode(response.body);
        dataresult = data.map((e) => StockManagerModel.fromJson(e)).toList();
      } else {
        return null!;
      }
    } on TimeoutException catch (_) {}
    return dataresult;
  }

  //
  Future<List<Brandsmodel>> BrandsTypes() async {
    var data = [];
    List<Brandsmodel> dataresult = [];
    try {
      final response = await apicall("select * from brands");

      if (response.statusCode == 200) {
        data = convert.jsonDecode(response.body);
        dataresult = data.map((e) => Brandsmodel.fromJson(e)).toList();
      } else {
        return null!;
      }
    } on TimeoutException catch (_) {}
    return dataresult;
  }

  //
  Future<List<Categerysmodel>> categoryTypes() async {
    var data = [];
    List<Categerysmodel> dataresult = [];
    try {
      final response = await apicall("select * from Categories");

      if (response.statusCode == 200) {
        data = convert.jsonDecode(response.body);
        dataresult = data.map((e) => Categerysmodel.fromJson(e)).toList();
      } else {
        return null!;
      }
    } on TimeoutException catch (_) {}
    return dataresult;
  }

  //
  Future<List<warehousemodel>> warehousetype() async {
    var data = [];
    List<warehousemodel> dataresult = [];
    try {
      final response = await apicall("select * from WareHouses");

      if (response.statusCode == 200) {
        data = convert.jsonDecode(response.body);
        dataresult = data.map((e) => warehousemodel.fromJson(e)).toList();
      } else {
        return null!;
      }
    } on TimeoutException catch (_) {}
    return dataresult;
  }
}

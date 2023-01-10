// ignore_for_file: null_check_always_fails

import 'dart:async';
import 'dart:convert' as convert;

import 'package:bm/Screens/special_books/account_manager/account_manager_model.dart';

import 'package:bm/main.dart';

class Service {
//fetch total today contractor from sql database

  Future<List<account_manager_model>> getallassetscounts() async {
    StreamController<List<account_manager_model>> streamController =
        StreamController();
    var data = [];
    List<account_manager_model> dataresult = [];
    try {
      final response = await apicall("select * from Accounts");

      if (response.statusCode == 200) {
        data = convert.jsonDecode(response.body);
        dataresult =
            data.map((e) => account_manager_model.fromJson(e)).toList();
        streamController.sink.add(dataresult);
      } else {
        return null!;
      }
    } on TimeoutException catch (_) {}
    return dataresult;
  }

  //
  Future<List<account_manager_model>> getcodes(String text) async {
    var data = [];
    List<account_manager_model> dataresult = [];
    try {
      final response =
          await apicall("select * from Accounts where TypeCode = '$text'");

      if (response.statusCode == 200) {
        data = convert.jsonDecode(response.body);
        dataresult =
            data.map((e) => account_manager_model.fromJson(e)).toList();
      } else {
        return null!;
      }
    } on TimeoutException catch (_) {}
    return dataresult;
  }

  //fetch total today contractor from sql database

  Future<List<AcTypeModel>> accountType() async {
    var data = [];
    List<AcTypeModel> dataresult = [];
    try {
      final response = await apicall("select * from Ac_Chart");

      if (response.statusCode == 200) {
        data = convert.jsonDecode(response.body);
        dataresult = data.map((e) => AcTypeModel.fromJson(e)).toList();
      } else {
        return null!;
      }
    } on TimeoutException catch (_) {}
    return dataresult;
  }
}

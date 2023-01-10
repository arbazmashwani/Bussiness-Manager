// ignore_for_file: null_check_always_fails

import 'dart:async';
import 'dart:convert' as convert;

import 'package:bm/Screens/special_books/ledgers_data/ledgers.dart';

import 'package:bm/main.dart';

class LedgerService {
//fetch total today contractor from sql database

  Future<List<LedgersModel>> getstockdata() async {
    var data = [];
    List<LedgersModel> dataresult = [];
    try {
      final response = await apicall(
          "SELECT Accounts.AcCode, Accounts.AcName, Accounts.Balance,Ac_Details.Telephone  FROM Accounts INNER JOIN Ac_Details ON Accounts.AcCode=Ac_Details.AcCode;");

      if (response.statusCode == 200) {
        data = convert.jsonDecode(response.body);
        dataresult = data.map((e) => LedgersModel.fromJson(e)).toList();
      } else {
        return null!;
      }
    } on TimeoutException catch (_) {}
    return dataresult;
  }

  //

}

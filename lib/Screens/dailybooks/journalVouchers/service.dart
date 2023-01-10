import 'dart:async';

import 'package:bm/Screens/dailybooks/journalVouchers/model.dart';

import 'package:bm/main.dart';
import 'dart:convert' as convert;

class Servicejournal {
  Future<List<jouranl_voucher_h_model>> getdata() async {
    var data = [];
    List<jouranl_voucher_h_model> dataresult = [];
    try {
      final response = await apicall("select * from Vouchers_H");

      if (response.statusCode == 200) {
        data = convert.jsonDecode(response.body);
        dataresult =
            data.map((e) => jouranl_voucher_h_model.fromJson(e)).toList();
      } else {
        return null!;
      }
    } on TimeoutException catch (_) {}
    return dataresult;
  }

  Future<List<jouranl_voucher_d_model>> getdataD() async {
    var data = [];
    List<jouranl_voucher_d_model> dataresult = [];
    try {
      final response = await apicall(
          "SELECT Accounts.AcName, Vouchers_D.EntryNo, Vouchers_D.VoucherNo, Vouchers_D.AcCode, Vouchers_D.Particulars, Vouchers_D.Debit,Vouchers_D.Credit FROM Vouchers_D INNER JOIN Accounts ON Accounts.AcCode=Vouchers_D.AcCode;");

      if (response.statusCode == 200) {
        data = convert.jsonDecode(response.body);
        dataresult =
            data.map((e) => jouranl_voucher_d_model.fromJson(e)).toList();
      } else {
        return null!;
      }
    } on TimeoutException catch (_) {}
    return dataresult;
  }
}

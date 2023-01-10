import 'dart:async';

import 'package:bm/Screens/dailybooks/journalVouchers/model.dart';
import 'package:bm/Screens/dailybooks/transfers/model.dart';

import 'package:bm/main.dart';
import 'dart:convert' as convert;

class Transferservice {
  Future<List<Transfers_H_model>> getdata() async {
    var data = [];
    List<Transfers_H_model> dataresult = [];
    try {
      final response = await apicall(
          "select EntryNo,TransNo,Dated,WH_From,WH_To,Notes, (select ac.WHDesc from Transfers_H rc join WareHouses ac on ac.WHCode = rc.WH_From where EntryNo = r.EntryNo) as 'Whfrom',(select ac.WHDesc from Transfers_H rc join WareHouses ac on ac.WHCode = rc.WH_To where EntryNo = r.EntryNo) as 'WhTo'from Transfers_H r");

      if (response.statusCode == 200) {
        data = convert.jsonDecode(response.body);
        dataresult = data.map((e) => Transfers_H_model.fromJson(e)).toList();
      } else {
        return null!;
      }
    } on TimeoutException catch (_) {}
    return dataresult;
  }

  Future<List<Transfers_D_model>> getdataD() async {
    var data = [];
    List<Transfers_D_model> dataresult = [];
    try {
      final response = await apicall("select * from Transfers_D");

      if (response.statusCode == 200) {
        data = convert.jsonDecode(response.body);
        dataresult = data.map((e) => Transfers_D_model.fromJson(e)).toList();
      } else {
        return null!;
      }
    } on TimeoutException catch (_) {}
    return dataresult;
  }
}

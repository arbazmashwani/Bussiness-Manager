import 'dart:async';

import 'package:bm/Screens/dailybooks/receipts/models.dart';
import 'package:bm/main.dart';
import 'dart:convert' as convert;

class ServiceReceipt {
  Future<List<ReceiptModel>> getdata() async {
    var data = [];
    List<ReceiptModel> dataresult = [];
    try {
      final response = await apicall(
          "select EntryNo,dated,Particulars,Amount,AcCredited,AcDebited,ConvRate, (select ac.AcName from Receipts rc join Accounts ac on ac.AcCode = rc.AcCredited where EntryNo = r.EntryNo) as 'RecieptFrom',(select ac.AcName  from Receipts rc join Accounts ac on ac.AcCode = rc.AcDebited where EntryNo = r.EntryNo) as 'ReceiptAs'from Receipts r");

      if (response.statusCode == 200) {
        data = convert.jsonDecode(response.body);
        dataresult = data.map((e) => ReceiptModel.fromJson(e)).toList();
      } else {
        return null!;
      }
    } on TimeoutException catch (_) {}
    return dataresult;
  }

  Future<List<ReceiptModel>> getpaymentsdata() async {
    var data = [];
    List<ReceiptModel> dataresult = [];
    try {
      final response = await apicall(
          "select EntryNo,dated,Particulars,Amount,AcCredited,AcDebited,ConvRate, (select ac.AcName from payments rc join Accounts ac on ac.AcCode = rc.AcCredited where EntryNo = r.EntryNo) as 'RecieptFrom',(select ac.AcName  from payments rc join Accounts ac on ac.AcCode = rc.AcDebited where EntryNo = r.EntryNo) as 'ReceiptAs'from payments r");

      if (response.statusCode == 200) {
        data = convert.jsonDecode(response.body);
        dataresult = data.map((e) => ReceiptModel.fromJson(e)).toList();
      } else {
        return null!;
      }
    } on TimeoutException catch (_) {}
    return dataresult;
  }
}

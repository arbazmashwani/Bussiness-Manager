import 'package:bm/Screens/special_books/ledgers_data/ledgers.dart';
import 'package:bm/Screens/special_books/ledgers_data/service.dart';
import 'package:bm/Screens/special_books/ledgerwidget.dart';

import 'package:flutter/material.dart';

class ExpenseLedger extends StatefulWidget {
  const ExpenseLedger({super.key});

  @override
  State<ExpenseLedger> createState() => _ExpenseLedgerState();
}

class _ExpenseLedgerState extends State<ExpenseLedger> {
  TextEditingController searchcontroller = TextEditingController();
  //lists of main account list
  List<LedgersModel> stocklist = [];
  List<LedgersModel> filterstocklist = [];
  List<LedgersModel> searchfilters = [];
  final LedgerService _service = LedgerService();

  //call data
  Future<void> getdata() async {
    stocklist = await _service.getstockdata();
    filterstocklist = stocklist
        .where((element) =>
            element.acCode.toString().toLowerCase()[0] == "E".toLowerCase())
        .toList();
    searchfilters =
        filterstocklist.where((element) => element.balance != 0).toList();
    setState(() {});
  }

  bool zeroedaccount = true;

  @override
  void initState() {
    getdata();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        //appbar

        backgroundColor: Colors.white.withOpacity(0.10),
        //floating action bar

        body: ledgerwidget(
            zeroedaccount,
            Checkbox(
                value: zeroedaccount,
                onChanged: (value) {
                  setState(() {
                    zeroedaccount = !zeroedaccount;
                    zeroedaccount == true
                        ? searchfilters = filterstocklist
                            .where((element) => element.balance != 0)
                            .toList()
                        : searchfilters = filterstocklist;
                  });
                }),
            context,
            searchfilters,
            width,
            _createDataTable(width),
            TextField(
              controller: searchcontroller,
              onChanged: ((value) {
                setState(() {
                  zeroedaccount = false;
                  searchfilters = filterstocklist
                      .where((element) => element.acName
                          .toString()
                          .toLowerCase()
                          .contains(searchcontroller.text.toLowerCase()))
                      .toList();
                });
              }),
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black38, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
                labelText: "Search",
                labelStyle: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            "EXPENSE SUMMARY"));
  }

  //datatable widgets
  DataTable _createDataTable(double wid) {
    return DataTable(
        columnSpacing: 0, columns: _createColumns(wid), rows: _createRows());
  }

  //datatable head list
  List<DataColumn> _createColumns(double wid) {
    return [
      DataColumn(
        label: SizedBox(
          width: wid * .1,
          child: const Text('A/c name',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
      ),
      DataColumn(
        label: SizedBox(
          width: wid * .1,
          child: const Text('Code',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
      ),
      DataColumn(
        label: SizedBox(
          width: wid * .1,
          child: const Text('Balance',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
      ),
      DataColumn(
        label: SizedBox(
          width: wid * .1,
          child: const Text('telephone',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
      ),
    ];
  }

  //datatable rows list , can ganerate from api future lists
  List<DataRow> _createRows() {
    return searchfilters
        .map((e) => DataRow(
                color: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  // Even rows will have a grey color.
                  if (searchfilters.indexOf(e) % 2 == 0) {
                    return Colors.black12;
                  }
                  return Colors
                      .white; // Use default value for other states and odd rows.
                }),
                cells: [
                  DataCell(Text(e.acCode.toString())),
                  DataCell(Text(e.acName.toString())),
                  DataCell(Text(e.balance.toString())),
                  DataCell(Text(e.telephone.toString().trim() == "null"
                      ? ""
                      : e.telephone.toString().trim())),
                ]))
        .toList();
  }
}

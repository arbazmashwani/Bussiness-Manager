import 'package:bm/Screens/special_books/stock_manager/stock_model.dart';
import 'package:bm/Screens/special_books/stock_manager/stock_service.dart';
import 'package:flutter/material.dart';

class stock_ledger extends StatefulWidget {
  const stock_ledger({super.key});

  @override
  State<stock_ledger> createState() => _stock_ledgerState();
}

// ignore: camel_case_types
class _stock_ledgerState extends State<stock_ledger> {
  TextEditingController searchcontroller = TextEditingController();
  //lists of main account list
  List<StockManagerModel> stocklist = [];
  List<StockManagerModel> filterstocklist = [];
  final StockService _service = StockService();

  //call data
  Future<void> getdata() async {
    stocklist = await _service.getstockdata();
    filterstocklist = stocklist;
    for (var e in filterstocklist) {
      totalstock.add(e.cost! * e.opQty!);
    }
    setState(() {});
  }

  @override
  void initState() {
    getdata();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appbar

        backgroundColor: Colors.white.withOpacity(0.10),
        //floating action bar

        body: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                child: Card(
              elevation: 10,
              child: Column(
                children: [
                  SizedBox(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          child: MaterialButton(
                            onPressed: () {
                              print(totalstock);
                            },
                            color: const Color.fromARGB(255, 109, 15, 2),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.print,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Print",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(child: Container()),
                        Expanded(
                            child: TextField(
                          controller: searchcontroller,
                          onChanged: ((value) {
                            totalstock.clear();

                            setState(() {
                              filterstocklist = stocklist
                                  .where((element) => element.iDescription
                                      .toString()
                                      .toLowerCase()
                                      .contains(
                                          searchcontroller.text.toLowerCase()))
                                  .toList();
                              for (var e in filterstocklist) {
                                totalstock.add(e.cost! * e.opQty!);
                              }
                            });
                          }),
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black38, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1),
                            ),
                            labelText: "Search",
                            labelStyle:
                                TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ))
                      ],
                    ),
                  )),
                  Expanded(
                      child: filterstocklist.isEmpty
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : SingleChildScrollView(
                              child: Column(
                                children: [_createDataTable()],
                              ),
                            )),
                  Container(
                    height: 40,
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 300, right: 100),
                      child: Row(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                const Text(
                                  "Total Quantity:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  stocklist
                                      .fold(
                                          0,
                                          (previousValue, element) =>
                                              previousValue + element.qtyIn!)
                                      .toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Container(
                            child: Row(
                              children: [
                                const Text(
                                  "Total Stock:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  totalstock
                                      .fold(
                                          0,
                                          (previousValue, element) =>
                                              previousValue + element)
                                      .toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
          ),
        ));
  }

  //datatable widgets
  DataTable _createDataTable() {
    return DataTable(
        columnSpacing: 50, columns: _createColumns(), rows: _createRows());
  }

  //datatable head list
  List<DataColumn> _createColumns() {
    return [
      const DataColumn(
          label: Text('Description',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text('Code',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text('QtyIn',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text('QtyOut',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text('Qty',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text('packing',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text('const',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text('stock',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
    ];
  }

  //datatable rows list , can ganerate from api future lists
  List<DataRow> _createRows() {
    return filterstocklist
        .map((e) => DataRow(
                color: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  // Even rows will have a grey color.
                  if (filterstocklist.indexOf(e) % 2 == 0) {
                    const stringkahna = "";
                    return Colors.black12;
                  }
                  return Colors
                      .white; // Use default value for other states and odd rows.
                }),
                cells: [
                  DataCell(Text(e.iDescription.toString())),
                  DataCell(Text(e.iCode.toString())),
                  DataCell(Text(e.qtyIn.toString())),
                  DataCell(Text(e.qtyOut.toString() == "null"
                      ? "0"
                      : e.qtyOut.toString())),
                  DataCell(Text(e.opQty.toString())),
                  DataCell(Text(e.packing.toString() == "null"
                      ? ""
                      : e.packing.toString())),
                  DataCell(Text(e.cost.toString())),
                  DataCell(Text((e.cost! * e.opQty!).toString())),
                ]))
        .toList();
  }

  List<int> totalstock = [];
}

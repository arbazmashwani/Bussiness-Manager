import 'package:bm/Screens/special_books/account_manager/account_manager_main.dart';
import 'package:bm/Screens/special_books/stock_manager/pdf.dart';
import 'package:bm/Screens/special_books/stock_manager/stock_model.dart';
import 'package:bm/Screens/special_books/stock_manager/stock_service.dart';
import 'package:bm/main.dart';
import 'package:bm/widgets.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

import 'dart:convert' as convert;

class StockMainPage extends StatefulWidget {
  const StockMainPage({super.key});

  @override
  State<StockMainPage> createState() => _StockMainPageState();
}

class _StockMainPageState extends State<StockMainPage> {
  //boolen for add screen
  bool addScreen = false;
  TextEditingController searchcontroller = TextEditingController();
  //lists of main account list
  List<StockManagerModel> stocklist = [];
  List<Brandsmodel> listu = [];
  List<Categerysmodel> listcategory = [];
  List<warehousemodel> warehousetype = [];
  List<StockManagerModel> filterstocklist = [];
  final StockService _service = StockService();
  String code = '';
  List<StockManagerModel> filtercode = [];

  //call data
  Future<void> getdata() async {
    stocklist = await _service.getstockdata();
    listu = await _service.BrandsTypes();
    listcategory = await _service.categoryTypes();
    warehousetype = await _service.warehousetype();
    filterstocklist = stocklist;
    setState(() {});
  }

  late SingleValueDropDownController _cnt;

  late SingleValueDropDownController _cnt2;

  @override
  void initState() {
    _cnt = SingleValueDropDownController();
    _cnt2 = SingleValueDropDownController();
    getdata();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appbar

        backgroundColor: Colors.white.withOpacity(0.10),
        //floating action bar

        body: addScreen == false
            ? Card(
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
                                    setState(() {
                                      addScreen = true;
                                    });
                                  },
                                  color: Colors.green,
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "ADD",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => PdfPreviewPage(
                                            invoice: filterstocklist),
                                      ),
                                    );
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
                              const SizedBox(
                                width: 5,
                              ),
                              addtype(
                                "Brand",
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              addtype(
                                "Category",
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              addtype(
                                "Warehouse",
                              ),
                              Expanded(child: Container()),
                              Expanded(
                                  child: TextField(
                                controller: searchcontroller,
                                onChanged: ((value) {
                                  setState(() {
                                    filterstocklist = stocklist
                                        .where((element) => element.iDescription
                                            .toString()
                                            .toLowerCase()
                                            .contains(searchcontroller.text
                                                .toLowerCase()))
                                        .toList();
                                  });
                                }),
                                decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black38, width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1),
                                  ),
                                  labelText: "Search",
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 15),
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
                            padding:
                                const EdgeInsets.only(left: 300, right: 100),
                            child: Row(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Quantity:",
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
                                                    previousValue +
                                                    element.qtyIn!)
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
                                Container(
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Stock:",
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
                                                    previousValue +
                                                    element.stockIn!)
                                            .toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
                ),
              )
            : Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      child: Card(
                    elevation: 10,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              child: DropDownTextField(
                                controller: _cnt,
                                dropDownItemCount: 6,
                                dropDownList: listcategory
                                    .map((e) => DropDownValueModel(
                                        name: e.desc.toString(), value: e.code))
                                    .toList(),
                                onChanged: ((value) async {}),
                                textFieldDecoration: const InputDecoration(
                                  labelText: "Category",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black38, width: 0.5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 0.5),
                                  ),
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ),
                            )),
                            Expanded(
                                child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              child: DropDownTextField(
                                controller: _cnt2,
                                dropDownItemCount: 6,
                                dropDownList: listu
                                    .map((e) => DropDownValueModel(
                                        name: e.desc.toString(),
                                        value: e.iCode))
                                    .toList(),
                                onChanged: ((value) async {
                                  filtercode = stocklist
                                      .where((element) => element.iCode
                                          .toString()
                                          .contains(
                                              "${_cnt.dropDownValue!.value.toString().trim()}${_cnt2.dropDownValue!.value.toString().trim()}"))
                                      .toList();
                                  setState(() {
                                    final numss = num.parse(filtercode.isEmpty
                                            ? "${_cnt.dropDownValue!.value.toString().trim()}${_cnt2.dropDownValue!.value.toString().trim()}000"
                                            : filtercode.last.iCode
                                                .toString()) +
                                        1;
                                    code = numss.toString();
                                  });
                                }),
                                textFieldDecoration: const InputDecoration(
                                  labelText: "Brand",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black38, width: 0.5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 0.5),
                                  ),
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ),
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: textfieldwidget(
                                  codecontroller..text = "00${code.toString()}",
                                  "Code/Serial",
                                  (v) {},
                                  1,
                                  1,
                                  20,
                                  true),
                            ),
                            Expanded(
                              child: textfieldwidget(
                                  serialcontroller..text = " ",
                                  "barcode/Shortname",
                                  (v) {},
                                  1,
                                  1,
                                  10,
                                  false),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        textfieldwidget(managerdescription2, "Description",
                            (v) {}, 1, 1, 50, false),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: textfieldwidget(
                                    bfqtycontroller..text = "0",
                                    "B/F Qty",
                                    (v) {},
                                    1,
                                    1,
                                    15,
                                    false)),
                            Expanded(
                                child: textfieldwidget(
                                    minqtycontroller..text = "0",
                                    "Min Qty",
                                    (v) {},
                                    1,
                                    1,
                                    15,
                                    false)),
                            Expanded(
                                child: textfieldwidget(
                                    maxqtycontroller..text = "0",
                                    "Max Qty",
                                    (v) {},
                                    1,
                                    1,
                                    15,
                                    false)),
                            Expanded(
                                child: textfieldwidget(packingcontroller,
                                    "Packing", (v) {}, 1, 1, 15, false))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: textfieldwidget(
                                    opcostcontroller..text = "0",
                                    "Op cost",
                                    (v) {},
                                    1,
                                    1,
                                    15,
                                    false)),
                            Expanded(child: Container()),
                            Expanded(
                                child: textfieldwidget(
                                    costcontroller..text = "0.0",
                                    "Cost",
                                    (v) {},
                                    1,
                                    1,
                                    15,
                                    false)),
                            Expanded(
                                child: textfieldwidget(
                                    retailcontroller..text = "0.0",
                                    "Retail",
                                    (v) {},
                                    1,
                                    1,
                                    15,
                                    false))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              errormessage2.isEmpty ? "" : errormessage2,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                child: MaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      addScreen = false;
                                    });
                                  },
                                  color: Colors.red,
                                  child: Row(
                                    children: const [
                                      Text(
                                        "Cancel",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                child: MaterialButton(
                                  onPressed: () async {
                                    int stock = int.parse(
                                            opcostcontroller.text.toString()) *
                                        int.parse(
                                            bfqtycontroller.text.toString());
                                    if (_cnt.dropDownValue == null ||
                                        _cnt2.dropDownValue == null) {
                                      setState(() {
                                        errormessage2 =
                                            "Select Category & Brand";
                                      });
                                    } else if (managerdescription2
                                        .text.isEmpty) {
                                      setState(() {
                                        errormessage2 = "Enter Description ";
                                      });
                                    } else {
                                      final response = await apicall(
                                          "INSERT INTO Stock (ICode, CCode, BCode, IDescription, INick , Packing, OpQty, QtyMin, QtyMax, PriceList,Cost,Rate,QtyIn,QtyOut, StockIn, StockOut) VALUES ('${codecontroller.text}', '${_cnt.dropDownValue!.value.toString().trim()}' , '${_cnt2.dropDownValue!.value.toString().trim()}', '${managerdescription2.text}', '${serialcontroller.text.toString().trim()}', '${packingcontroller.text.toString().trim()}', '${bfqtycontroller.text.toString().trim()}', '${minqtycontroller.text.toString().trim()}', '${maxqtycontroller.text.toString().trim()}', '${opcostcontroller.text.toString().trim()}', '${costcontroller.text.toString().trim()}', '${retailcontroller.text.toString().trim()}', '${bfqtycontroller.text.toString().trim()}', '0','${stock.toString().trim()}', '0');");
                                      setState(() {
                                        addScreen = false;
                                        getdata();
                                      });
                                    }
                                  },
                                  color: Colors.green,
                                  child: Row(
                                    children: const [
                                      Text(
                                        "Post",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
                ),
              ));
  }

  TextEditingController codecontroller = TextEditingController();
  TextEditingController serialcontroller = TextEditingController();
  TextEditingController managerdescription = TextEditingController();
  TextEditingController managerdescription2 = TextEditingController();
  TextEditingController bfqtycontroller = TextEditingController();
  TextEditingController minqtycontroller = TextEditingController();
  TextEditingController maxqtycontroller = TextEditingController();
  TextEditingController packingcontroller = TextEditingController();
  TextEditingController opcostcontroller = TextEditingController();
  TextEditingController costcontroller = TextEditingController();
  TextEditingController retailcontroller = TextEditingController();

  //datatable widgets
  DataTable _createDataTable() {
    return DataTable(
        columnSpacing: 40, columns: _createColumns(), rows: _createRows());
  }

  //datatable head list
  List<DataColumn> _createColumns() {
    return [
      const DataColumn(
          label: Text('Code',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text('Description',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text('Qty',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text('Packing',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text('Cost',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text('Stock',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text('Action',
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
                    return Colors.black12;
                  }
                  return Colors
                      .white; // Use default value for other states and odd rows.
                }),
                cells: [
                  DataCell(Text(e.iCode.toString())),
                  DataCell(Text(e.iDescription.toString())),
                  DataCell(Text(e.qtyIn.toString())),
                  DataCell(Text(e.packing.toString() == "null"
                      ? ""
                      : e.packing.toString())),
                  DataCell(Text(e.priceList.toString())),
                  DataCell(Text(e.stockIn.toString())),
                  DataCell(Row(
                    children: [
                      IconButton(
                          onPressed: () async {},
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          )),
                      IconButton(
                          onPressed: () async {
                            final response = await apicall(
                                "delete from stock where ICode = ${e.iCode.toString()}");
                            setState(() {
                              getdata();
                            });
                            print(response.body.toString());
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ))
                    ],
                  ))
                ]))
        .toList();
  }

  final TextEditingController _codecontroller = TextEditingController();
  final TextEditingController _desccontroller = TextEditingController();

  addtype(String text) {
    return SizedBox(
      child: MaterialButton(
        onPressed: () async {
          showDialog(
              context: context,
              builder: ((context) {
                num Num = 0;
                String coe = '';
                if (text == "Brand") {
                  Num = num.parse(listu.last.iCode.toString()) + 1;
                  coe = Num.toString().trim();
                } else if (text == "Category") {
                  Num = num.parse(listcategory.last.code.toString()) + 1;
                  coe = Num.toString().trim();
                } else if (text == "Warehouse") {
                  Num = num.parse(warehousetype.last.code.toString()) + 1;
                  coe = Num.toString().trim();
                }
                _desccontroller.clear();
                return AlertDialog(
                  title: Text(text),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Card(
                        elevation: 10,
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              namewidget("Code"),
                              textfieldwidget(
                                  _codecontroller
                                    ..text = coe.length < 2
                                        ? text == "Category"
                                            ? coe.toString().padLeft(3, "0")
                                            : coe.toString().padLeft(2, "0")
                                        : coe.toString(),
                                  "",
                                  (value) {},
                                  1,
                                  1,
                                  3,
                                  true),
                              namewidget("Description"),
                              textfieldwidget(_desccontroller, "", (value) {},
                                  3, 3, 20, false),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: SizedBox(
                                      child: MaterialButton(
                                        onPressed: () async {
                                          if (_desccontroller.text.isNotEmpty) {
                                            if (text == "Brand") {
                                              await apicall(
                                                  "INSERT INTO brands (BCode, BDescription) VALUES ('${_codecontroller.text}', '${_desccontroller.text}');");
                                            } else if (text == "Category") {
                                              await apicall(
                                                  "INSERT INTO Categories (CCode, CDescription) VALUES ('${_codecontroller.text}', '${_desccontroller.text}');");
                                            } else if (text == "Warehouse") {
                                              await apicall(
                                                  "INSERT INTO WareHouses (WHCode, WHDesc) VALUES ('${_codecontroller.text}', '${_desccontroller.text}');");
                                            }
                                            getdata();
                                            Navigator.pop(context);
                                          } else {}
                                        },
                                        color: Colors.green,
                                        child: Row(
                                          children: const [
                                            Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              "ADD",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }));
        },
        color: const Color.fromARGB(255, 88, 2, 81),
        child: Row(
          children: [
            Text(
              text,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  String errormessage2 = "";
}

import 'dart:async';
import 'dart:math';

import 'package:bm/Screens/dailybooks/receipts/models.dart';
import 'package:bm/Screens/dailybooks/receipts/receiptpdf.dart';
import 'package:bm/Screens/dailybooks/receipts/service.dart';
import 'package:bm/Screens/dailybooks/receipts/userbalancepdf.dart';
import 'package:bm/Screens/special_books/account_manager/account_manager_main.dart';
import 'package:bm/Screens/special_books/account_manager/account_manager_model.dart';
import 'package:bm/Screens/special_books/stock_manager/pdf.dart';
import 'package:bm/main.dart';

import 'package:bm/widgets.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../special_books/account_manager/account_manager_service.dart';

class ReceiptPageMain extends StatefulWidget {
  const ReceiptPageMain({super.key});

  @override
  State<ReceiptPageMain> createState() => _ReceiptPageMainState();
}

class _ReceiptPageMainState extends State<ReceiptPageMain> {
  final ServiceReceipt _service = ServiceReceipt();
  final Service remaingbalanceservice = Service();
  List<account_manager_model> remaingbalancelist = [];
  List<ReceiptModel> accountlistusers = [];
  List<ReceiptModel> filteraccountlist = [];
  List<ReceiptModel> searchlist = [];
  List<ReceiptModel> filterbydatelist = [];
  String receivefrom = "";
  String receiveas = "";
  String currentbalance = "";
  String receivefromBalance = "";
  String receiveasBalance = "";
  String errormessage = "";
  String particulars = "";
  String amountstring = "";
  String datefilterstring =
      DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();
  String cashgiver = "";
  String cashreceiver = "";

  TextEditingController searchcontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController entrydatecontroller = TextEditingController();
  TextEditingController credittercontroller = TextEditingController();
  TextEditingController debittercontroller = TextEditingController();
  TextEditingController particularcontroller = TextEditingController();
  // TextEditingController datecontroller = TextEditingController();
  TextEditingController $controller = TextEditingController();
  TextEditingController amountcontroller = TextEditingController();

  bool addScreen = true;

  num Num = 0;

  Future<void> getdata() async {
    remaingbalancelist = await remaingbalanceservice.getallassetscounts();
    accountlistusers = await _service.getdata();
    filterbydatelist = accountlistusers
        .where((element) =>
            DateFormat("yyyy-MM-dd").format(element.dated!).toString() ==
            datefilterstring)
        .toList();
    Num = num.parse(accountlistusers.isEmpty
            ? 00000.toString()
            : accountlistusers.last.entryno.toString()) +
        1;
    setState(() {});
  }

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
                              filteraccountlist.isEmpty
                                  ? Container()
                                  : SizedBox(
                                      child: MaterialButton(
                                        onPressed: () {
                                          setState(() {
                                            filteraccountlist.clear();
                                          });
                                        },
                                        color: Colors.red,
                                        child: Row(
                                          children: const [
                                            Icon(
                                              Icons.arrow_back_ios,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              "Back",
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
                              filteraccountlist.isEmpty
                                  ? Container()
                                  : SizedBox(
                                      child: MaterialButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ReceiptPdfMain(
                                                invoice: searchlist,
                                                textjournal: "Receipt",
                                              ),
                                            ),
                                          );
                                        },
                                        color: const Color.fromARGB(
                                            255, 109, 15, 2),
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
                                  child: filteraccountlist.isEmpty
                                      ? Container()
                                      : TextField(
                                          controller: searchcontroller,
                                          onChanged: ((value) {
                                            setState(() {
                                              searchlist = filteraccountlist
                                                  .where((element) => element
                                                      .recieptFrom
                                                      .toString()
                                                      .trim()
                                                      .toLowerCase()
                                                      .contains(searchcontroller
                                                          .text
                                                          .toLowerCase()))
                                                  .toList();
                                            });
                                          }),
                                          decoration: const InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black38,
                                                  width: 1),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 1),
                                            ),
                                            labelText: "Search",
                                            labelStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                        ))
                            ],
                          ),
                        )),
                        Expanded(
                            child: filteraccountlist.isEmpty
                                ? Card(
                                    elevation: 0,
                                    child: Container(
                                      child: Center(
                                          child: Container(
                                        width: 300,
                                        color: Colors.white,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            namewidget("Trial balance for"),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            TextField(
                                              decoration: const InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black38,
                                                      width: 0.5),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black,
                                                      width: 0.5),
                                                ),
                                                label: Text("Select Date"),
                                                labelStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15),
                                              ),
                                              controller: datecontroller,
                                              onTap: () async {
                                                DateTime? showdate =
                                                    await showDatePicker(
                                                        context: context,
                                                        initialDate:
                                                            DateTime.now(),
                                                        firstDate:
                                                            DateTime(2000),
                                                        lastDate:
                                                            DateTime(3000));

                                                if (showdate != null) {
                                                  setState(() {
                                                    datecontroller.text =
                                                        DateFormat("yyyy-MM-dd")
                                                            .format(showdate);
                                                  });
                                                }
                                              },
                                            ),
                                            Text(
                                              errormessage.isEmpty
                                                  ? ""
                                                  : errormessage,
                                              style: const TextStyle(
                                                  color: Colors.red),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                MaterialButton(
                                                  onPressed: () async {
                                                    datecontroller.text.isEmpty
                                                        ? setState(() {
                                                            errormessage =
                                                                "select Date";
                                                          })
                                                        : setState(() {
                                                            errormessage = "";
                                                            DateTime dt1 = DateFormat(
                                                                    "yyyy-MM-dd")
                                                                .parse(
                                                                    "2007-01-01");
                                                            DateTime dt2 = DateFormat(
                                                                    "yyyy-MM-dd")
                                                                .parse(
                                                                    datecontroller
                                                                        .text);
                                                            print("$dt1 khan");
                                                            print("$dt2 khan");

                                                            filteraccountlist =
                                                                accountlistusers
                                                                    .where((e) =>
                                                                        (dt1.compareTo(DateTime.parse(e.dated!.toString().trim())) <=
                                                                                0
                                                                            //     //DateTime.parse(e.date!)) <= 0
                                                                            &&
                                                                            dt2.compareTo(DateTime.parse(e.dated!.toString().trim())) >=
                                                                                0

                                                                        // // DateTime.parse(e.date!)) >= 0
                                                                        ))
                                                                    .toList();

                                                            if (filteraccountlist
                                                                .isEmpty) {
                                                              errormessage =
                                                                  "No Data Found";
                                                            } else {
                                                              searchlist =
                                                                  filteraccountlist;
                                                            }

                                                            print(datecontroller
                                                                .text);
                                                            print(
                                                                filteraccountlist
                                                                    .length);
                                                          });
                                                  },
                                                  color: Colors.green,
                                                  child: const Text(
                                                    "Search",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )),
                                    ),
                                  )
                                : SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: _createDataTable(searchlist))
                                      ],
                                    ),
                                  )),
                        filteraccountlist.isEmpty
                            ? Container()
                            : Container(
                                height: 40,
                                color: Colors.red,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 100, right: 100),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [],
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
                          child: Column(children: [
                            Expanded(
                                flex: 7,
                                child: Container(
                                  color: Colors.white,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Container(
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      child: MaterialButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            addScreen = false;
                                                          });
                                                        },
                                                        color: Colors.green,
                                                        child: Row(
                                                          children: const [
                                                            Icon(
                                                              Icons.view_agenda,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            Text(
                                                              "View",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                  ],
                                                ),
                                              )),
                                              Expanded(
                                                child: TextField(
                                                  readOnly: true,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: "Entry Date:",
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black38,
                                                          width: 0.5),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black,
                                                          width: 0.5),
                                                    ),
                                                    labelStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),
                                                  ),
                                                  controller:
                                                      entrydatecontroller
                                                        ..text =
                                                            datefilterstring,
                                                  onTap: () async {
                                                    DateTime? showdate =
                                                        await showDatePicker(
                                                            context: context,
                                                            initialDate:
                                                                DateTime.now(),
                                                            firstDate:
                                                                DateTime(2000),
                                                            lastDate:
                                                                DateTime(3000));

                                                    if (showdate != null) {
                                                      setState(() {
                                                        receivefrom = "";
                                                        receiveas = "";
                                                        receivefromBalance = "";
                                                        receiveasBalance = "";
                                                        getdata();
                                                        datefilterstring =
                                                            DateFormat(
                                                                    "yyyy-MM-dd")
                                                                .format(
                                                                    showdate);
                                                      });
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          height: 1000,
                                          child: _createDataTable2(
                                              filterbydatelist, width),
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                            Expanded(
                                flex: 4,
                                child: Card(
                                  elevation: 100,
                                  child: Card(
                                    elevation: 10,
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 20,
                                            color: Colors.red,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 100, right: 100),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    "Total Balance:",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    filterbydatelist
                                                        .fold(
                                                            0,
                                                            (previousValue,
                                                                    element) =>
                                                                previousValue +
                                                                element.amount!)
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                              height: 50,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      child: Container(
                                                          child: textfields(
                                                              credittercontroller,
                                                              "AC CR", () {
                                                    selectcrediter("CR");
                                                  }, true))),
                                                  Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                          child: textfields(
                                                              particularcontroller,
                                                              "Particular",
                                                              () {},
                                                              false))),
                                                  Expanded(
                                                      child: Container(
                                                          child: textfields(
                                                              amountcontroller,
                                                              "Amount",
                                                              () {},
                                                              false))),
                                                  Expanded(
                                                      child: Container(
                                                          child: textfields(
                                                              $controller
                                                                ..text = "1.0",
                                                              "\$Rate",
                                                              () {},
                                                              false))),
                                                  Expanded(
                                                      child: Container(
                                                          child: textfields(
                                                              debittercontroller,
                                                              "AC DR",
                                                              () async {
                                                    await selectcrediter("DR");
                                                    if (credittercontroller
                                                        .text.isEmpty) {
                                                      debittercontroller
                                                          .clear();
                                                      // ignore: use_build_context_synchronously
                                                      displayToastMessage(
                                                          "Please Select credit Account First",
                                                          context);
                                                    } else if (debittercontroller
                                                        .text.isEmpty) {
                                                      // ignore: use_build_context_synchronously
                                                      displayToastMessage(
                                                          "Please Select Debit Account",
                                                          context);
                                                    } else if (amountcontroller
                                                        .text.isEmpty) {
                                                      debittercontroller
                                                          .clear();
                                                      // ignore: use_build_context_synchronously
                                                      displayToastMessage(
                                                          "Amount Is Required To Received",
                                                          context);
                                                    } else if (credittercontroller
                                                            .text
                                                            .toString()
                                                            .trim() ==
                                                        debittercontroller.text
                                                            .toString()
                                                            .trim()) {
                                                      debittercontroller
                                                          .clear();
                                                      // ignore: use_build_context_synchronously
                                                      displayToastMessage(
                                                          "Please Select Different Accounts, accounts cant be same",
                                                          context);
                                                    } else {
                                                      await getdata();
                                                      await apicall(
                                                          "INSERT INTO Receipts (EntryNo, Dated, AcCredited, Particulars, AcDebited, Amount, ConvRate) VALUES ('${Num.toString()}', '$datefilterstring', '${credittercontroller.text}', '${particularcontroller.text}', '${debittercontroller.text}', '${amountcontroller.text}', '1');");
                                                      final res = await apicall(
                                                          "update Accounts set Balance= Balance -${amountcontroller.text} where AcName = '${cashgiver}'");
                                                      await apicall(
                                                          "update Accounts set Balance= Balance +${amountcontroller.text} where AcName = '${cashreceiver}'");

                                                      // ignore: use_build_context_synchronously
                                                      displayToastMessage(
                                                          res.body.toString(),
                                                          context);

                                                      setState(() {
                                                        getdata();
                                                      });
                                                    }
                                                  }, true))),
                                                ],
                                              )),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    flex: 7,
                                                    child: Container(
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  namewidget(
                                                                      "Receipt from:"),
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text(
                                                                    receivefrom,
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .blue,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  namewidget(
                                                                      "A/C Balance:"),
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text(
                                                                    receivefromBalance,
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .blue,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  namewidget(
                                                                      "Receipt AS:"),
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text(
                                                                    receiveas,
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .blue,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  namewidget(
                                                                      "A/C Balance:"),
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text(
                                                                    receiveasBalance,
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .blue,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    )),
                                                Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 5),
                                                      child: Container(
                                                        child: Center(
                                                          child: receivefrom
                                                                      .isEmpty &&
                                                                  receiveas
                                                                      .isEmpty
                                                              ? Container()
                                                              : SizedBox(
                                                                  child:
                                                                      MaterialButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .push(
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              Userbalancepdf(
                                                                            currentbalance:
                                                                                currentbalance,
                                                                            particulars:
                                                                                particulars,
                                                                            textjournal:
                                                                                "Receipt",
                                                                            amount:
                                                                                amountstring,
                                                                            receiveas:
                                                                                receiveas,
                                                                            receivefrom:
                                                                                receivefrom,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                    color: const Color
                                                                            .fromARGB(
                                                                        255,
                                                                        109,
                                                                        15,
                                                                        2),
                                                                    child: Row(
                                                                      children: const [
                                                                        Icon(
                                                                          Icons
                                                                              .print,
                                                                          color:
                                                                              Colors.white,
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
                                                        ),
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                          ]))),
                ),
              ));
  }

  //datatable widgets
  DataTable _createDataTable(List<ReceiptModel> list) {
    return DataTable(
        columnSpacing: 20, columns: _createColumns(), rows: _createRows(list));
  }

  DataTable _createDataTable2(List<ReceiptModel> list, double wid) {
    return DataTable(
        headingRowColor:
            MaterialStateColor.resolveWith((states) => Colors.black12),
        border: TableBorder.all(color: Colors.black12),
        showCheckboxColumn: false,
        columns: _createColumns2(wid),
        rows: _createRows(list));
  }

  //datatable head list
  List<DataColumn> _createColumns() {
    return [
      const DataColumn(
          label: Text('Date',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text('Receipt from (Credit)',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text('Particulars',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text('Amount',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text('Receipt as(Debit)',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
    ];
  }

  List<DataColumn> _createColumns2(double wid) {
    return [
      const DataColumn(
          label: SizedBox(
        child: Text('AC CR',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      )),
      DataColumn(
          label: SizedBox(
        width: wid * .2,
        child: const Text('Particulars',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      )),
      const DataColumn(
          label: SizedBox(
        child: Text('\$RATE',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      )),
      const DataColumn(
          label: SizedBox(
        child: Text('Amount',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      )),
      DataColumn(
          label: SizedBox(
        width: wid * .1,
        child: const Text('AC DR',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      )),
    ];
  }

  //datatable rows list , can ganerate from api future lists
  List<DataRow> _createRows(List<ReceiptModel> list) {
    if (list == filterbydatelist) {
      return list
          .map((e) => DataRow(
                  onSelectChanged: (newValue) {
                    receivefrom = e.recieptFrom.toString().trim();
                    receiveas = e.receiptAs.toString().trim();
                    List<account_manager_model> receivefrombal = [];
                    List<account_manager_model> receiveasbal = [];

                    receivefrombal = remaingbalancelist
                        .where((element) =>
                            element.acName.toString().trim().toLowerCase() ==
                            receivefrom.toLowerCase())
                        .toList();
                    receiveasbal = remaingbalancelist
                        .where((element) =>
                            element.acName.toString().trim().toLowerCase() ==
                            receiveas.toLowerCase())
                        .toList();

                    setState(() {
                      receivefromBalance =
                          receivefrombal.first.balance.toString();
                      receiveasBalance = receiveasbal.first.balance.toString();
                      amountstring = e.amount.toString();
                      particulars = e.particulars.toString();
                      currentbalance = receivefromBalance;
                    });
                  },
                  cells: [
                    DataCell(Text(e.acCredited.toString().trim())),
                    DataCell(Text(e.particulars.toString().trim())),
                    DataCell(Text(e.convRate.toString().trim())),
                    DataCell(Text(e.amount.toString())),
                    DataCell(Text(e.acDebited.toString())),
                  ]))
          .toList();
    } else {
      return list
          .map((e) => DataRow(
                  color: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    // Even rows will have a grey color.
                    if (filteraccountlist.indexOf(e) % 2 == 0) {
                      return Colors.black12;
                    }
                    return Colors
                        .white; // Use default value for other states and odd rows.
                  }),
                  cells: [
                    DataCell(Text(DateFormat("yyyy-MM-dd")
                        .format(DateTime.parse(e.dated.toString()))
                        .toString())),
                    DataCell(Text(e.recieptFrom.toString())),
                    DataCell(Text(e.particulars.toString())),
                    DataCell(Text(e.amount.toString())),
                    DataCell(Text(e.receiptAs.toString())),
                  ]))
          .toList();
    }
  }

  selectcrediter(String textcheck) {
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            content: SizedBox(
                width: 400,
                height: 500,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 95 *
                            double.parse(remaingbalancelist.length.toString()),
                        width: 400,
                        child: ListView.separated(
                            separatorBuilder: (_, __) => Divider(),
                            itemCount: remaingbalancelist.length,
                            itemBuilder: ((context, index) {
                              account_manager_model users =
                                  remaingbalancelist[index];
                              return Card(
                                elevation: 5,
                                child: ListTile(
                                  onTap: () {
                                    setState(() {
                                      if (textcheck == "CR") {
                                        credittercontroller.text =
                                            users.acCode.toString().trim();
                                        cashgiver = users.acName.toString();
                                      } else if (textcheck == "DR") {
                                        debittercontroller.text =
                                            users.acCode.toString().trim();
                                        cashreceiver = users.acName.toString();
                                      }
                                    });
                                    Navigator.pop(context);
                                  },
                                  title: Text(users.acName.toString()),
                                  subtitle: Text(users.typeCode.toString()),
                                  trailing: Text(users.balance.toString()),
                                ),
                              );
                            })),
                      ),
                    ],
                  ),
                )),
          );
        }));
  }

  String crediter = "";
}

buildwidgetextra(TextEditingController controller, String title, String data,
    bool bool, void Function(value)) {
  return Row(
    children: [
      Expanded(flex: 2, child: Text(title)),
      Expanded(
          flex: 8,
          child: textfieldwidget2(
              controller..text = data, "", Function, 1, 1, 20, bool))
    ],
  );
}

import 'package:bm/Screens/dailybooks/transfers/model.dart';
import 'package:bm/Screens/dailybooks/transfers/service.dart';
import 'package:bm/Screens/special_books/account_manager/account_manager_main.dart';
import 'package:bm/main.dart';

import 'package:bm/widgets.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../special_books/account_manager/account_manager_model.dart';
import '../../special_books/account_manager/account_manager_service.dart';

class TransferMainpage extends StatefulWidget {
  const TransferMainpage({super.key});

  @override
  State<TransferMainpage> createState() => _TransferMainpageState();
}

class _TransferMainpageState extends State<TransferMainpage> {
  List<account_manager_model> remaingbalancelist = [];
  List<Transfers_H_model> journallist_h = [];
  List<Transfers_D_model> journallist_d = [];
  List<Transfers_D_model> Filterjournallist_d = [];

  int number = 0;
  num entrynumber = 00000;

  List<Transfers_H_model> filteraccountlistbydate = [];
  final Transferservice _service = Transferservice();
  String errormessage = "";
  TextEditingController credittercontroller = TextEditingController();
  TextEditingController debittercontroller = TextEditingController();
  TextEditingController particularcontroller = TextEditingController();
  TextEditingController dontroller = TextEditingController();
  TextEditingController $controller = TextEditingController();
  TextEditingController amountcontroller = TextEditingController();
  final Service remaingbalanceservice = Service();

  Future<void> getdata() async {
    remaingbalancelist = await remaingbalanceservice.getallassetscounts();
    journallist_h = await _service.getdata();
    journallist_d = await _service.getdataD();
    number = journallist_h.length - 1;

    Filterjournallist_d = journallist_d
        .where((element) =>
            element.transNo.toString().trim().toLowerCase() ==
            journallist_h[number].transNo.toString().trim().toLowerCase())
        .toList();

    entrynumber = (num.parse(journallist_h.last.entryNo!)) + 1;
    // filteraccountlistbydate = journallist
    //     .where((element) =>
    //         DateFormat("yyyy-MM-dd")
    //             .format(DateTime.parse(element.dated!))
    //             .toString() ==
    //         datefilterstring)
    //     .toList();
    setState(() {});
  }

  Future<void> getdata2() async {
    remaingbalancelist = await remaingbalanceservice.getallassetscounts();
    journallist_h = await _service.getdata();
    journallist_d = await _service.getdataD();

    Filterjournallist_d = journallist_d
        .where((element) =>
            element.transNo.toString().trim().toLowerCase() ==
            journallist_h[number == journallist_h.length - 1
                    ? journallist_h.length - 1
                    : number]
                .transNo
                .toString()
                .trim()
                .toLowerCase())
        .toList();

    // filteraccountlistbydate = journallist
    //     .where((element) =>
    //         DateFormat("yyyy-MM-dd")
    //             .format(DateTime.parse(element.dated!))
    //             .toString() ==
    //         datefilterstring)
    //     .toList();
    setState(() {});
  }

  String datefilterstring =
      DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();
  String voucherdateadd =
      DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();

  TextEditingController datecontroller = TextEditingController();
  TextEditingController datecontroller2 = TextEditingController();

  bool addScreen = true;

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
                              filteraccountlistbydate.isEmpty
                                  ? Container()
                                  : SizedBox(
                                      child: MaterialButton(
                                        onPressed: () {
                                          setState(() {
                                            filteraccountlistbydate.clear();
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
                              filteraccountlistbydate.isEmpty
                                  ? Container()
                                  : SizedBox(
                                      child: MaterialButton(
                                        onPressed: () {},
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
                                  child: filteraccountlistbydate.isEmpty
                                      ? Container()
                                      : const TextField(
                                          decoration: InputDecoration(
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
                            child: filteraccountlistbydate.isEmpty
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

                                                            filteraccountlistbydate =
                                                                journallist_h
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

                                                            if (filteraccountlistbydate
                                                                .isEmpty) {
                                                              errormessage =
                                                                  "No Data Found";
                                                            } else {}
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
                                        SizedBox(
                                          height: 75 *
                                              double.parse(
                                                  filteraccountlistbydate.length
                                                      .toString()),
                                          child: ListView.builder(
                                              itemCount: filteraccountlistbydate
                                                  .length,
                                              itemBuilder: ((context, index) {
                                                Transfers_H_model user =
                                                    filteraccountlistbydate[
                                                        index];
                                                return Card(
                                                  elevation: 10,
                                                  child: ListTile(
                                                    subtitle: Text(
                                                        user.wHFrom.toString()),
                                                    title: Text(user.transNo
                                                        .toString()),
                                                  ),
                                                );
                                              })),
                                        )
                                      ],
                                    ),
                                  )),
                        filteraccountlistbydate.isEmpty
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
                                              left: 8, right: 8, top: 8),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          child: MaterialButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                addScreen =
                                                                    false;
                                                              });
                                                            },
                                                            color: Colors.green,
                                                            child: Row(
                                                              children: const [
                                                                Icon(
                                                                  Icons
                                                                      .view_agenda,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                Text(
                                                                  "List",
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
                                                        SizedBox(
                                                          child: MaterialButton(
                                                            onPressed:
                                                                () async {
                                                              await getdata();
                                                              alertDialogsss();
                                                            },
                                                            color: Colors.green,
                                                            child: Row(
                                                              children: const [
                                                                Icon(
                                                                  Icons.add,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                Text(
                                                                  "Slip",
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
                                                        SizedBox(
                                                          child: MaterialButton(
                                                            onPressed: () {},
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    77,
                                                                    2,
                                                                    2),
                                                            child: Row(
                                                              children: const [
                                                                Icon(
                                                                  Icons.print,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                Text(
                                                                  "Print",
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
                                                      ],
                                                    ),
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child: textfields(
                                                      voucherscontroller
                                                        ..text = journallist_h
                                                                .isEmpty
                                                            ? "-"
                                                            : journallist_h[
                                                                    number]
                                                                .transNo
                                                                .toString()
                                                                .trim(),
                                                      "Slip No",
                                                      () {},
                                                      false)),
                                              Expanded(
                                                  flex: 1,
                                                  child: textfields(
                                                      datecontroller2
                                                        ..text = DateFormat(
                                                                "yyyy-MM-dd")
                                                            .format(DateTime.parse(journallist_h
                                                                    .isEmpty
                                                                ? "2000-01-01"
                                                                : journallist_h[
                                                                        number]
                                                                    .dated
                                                                    .toString()
                                                                    .trim()))
                                                            .toString(),
                                                      "Date",
                                                      () {},
                                                      false)),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              number == 0
                                                  ? Container()
                                                  : IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          if (number != 0) {
                                                            setState(() {
                                                              number--;
                                                              Filterjournallist_d = journallist_d
                                                                  .where((element) =>
                                                                      element
                                                                          .transNo
                                                                          .toString()
                                                                          .trim()
                                                                          .toLowerCase() ==
                                                                      journallist_h[
                                                                              number]
                                                                          .transNo
                                                                          .toString()
                                                                          .trim()
                                                                          .toLowerCase())
                                                                  .toList();
                                                            });
                                                          }
                                                        });
                                                      },
                                                      icon: const Icon(Icons
                                                          .arrow_back_ios)),
                                              Expanded(
                                                flex: 2,
                                                child: journallist_h.isEmpty
                                                    ? Container()
                                                    : textfields(
                                                        dontroller
                                                          ..text = journallist_h
                                                                  .isEmpty
                                                              ? "-"
                                                              : journallist_h[number]
                                                                          .notes
                                                                          .toString()
                                                                          .trim() ==
                                                                      ""
                                                                  ? "empty"
                                                                  : journallist_h
                                                                          .isEmpty
                                                                      ? "-"
                                                                      : journallist_h[
                                                                              number]
                                                                          .notes
                                                                          .toString()
                                                                          .trim(),
                                                        "Remarks",
                                                        () {},
                                                        true,
                                                      ),
                                              ),
                                              number == journallist_h.length - 1
                                                  ? Container()
                                                  : IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          if (number !=
                                                              journallist_h
                                                                      .length -
                                                                  1) {
                                                            setState(() {
                                                              number++;
                                                              Filterjournallist_d = journallist_d
                                                                  .where((element) =>
                                                                      element
                                                                          .transNo
                                                                          .toString()
                                                                          .trim()
                                                                          .toLowerCase() ==
                                                                      journallist_h[
                                                                              number]
                                                                          .transNo
                                                                          .toString()
                                                                          .trim()
                                                                          .toLowerCase())
                                                                  .toList();
                                                            });
                                                          }
                                                        });
                                                      },
                                                      icon: const Icon(Icons
                                                          .arrow_forward_ios)),
                                              Expanded(
                                                  child: Container(
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: textfields(
                                                          remarkscontroller
                                                            ..text = journallist_h
                                                                    .isEmpty
                                                                ? "-"
                                                                : journallist_h[
                                                                        number]
                                                                    .Whfromname
                                                                    .toString()
                                                                    .trim(),
                                                          "LOC.FROM",
                                                          () {},
                                                          false),
                                                    ),
                                                    Expanded(
                                                      child: textfields(
                                                          $controller
                                                            ..text = journallist_h
                                                                    .isEmpty
                                                                ? "-"
                                                                : journallist_h[
                                                                        number]
                                                                    .whToname
                                                                    .toString(),
                                                          "LOC.TO",
                                                          () {},
                                                          false),
                                                    )
                                                  ],
                                                ),
                                              )),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                            height: 1000,
                                            child: _createDataTable(width)),
                                      ],
                                    ),
                                  ),
                                )),
                            Expanded(
                                flex: 2,
                                child: Card(
                                  elevation: 100,
                                  child: Container(
                                    color: Colors.white38,
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 20,
                                          color: Colors.red,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 100, right: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  "Total:",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      Filterjournallist_d.fold(
                                                              0,
                                                              (previousValue,
                                                                      element) =>
                                                                  previousValue +
                                                                  element.qty!)
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
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
                                                            amountcontroller
                                                              ..text = "0",
                                                            "Debit",
                                                            () {},
                                                            false))),
                                                Expanded(
                                                    child: Container(
                                                        child: textfields(
                                                            debittercontroller
                                                              ..text = "0",
                                                            "Credit",
                                                            () async {},
                                                            false))),
                                                Expanded(
                                                    child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                      child: MaterialButton(
                                                    onPressed: () async {
                                                      final num numsentry = (journallist_d
                                                                  .isNotEmpty
                                                              ? num.parse(
                                                                  journallist_d
                                                                      .last
                                                                      .entryNo
                                                                      .toString())
                                                              : 00000) +
                                                          1;
                                                      // final res = await apicall(
                                                      //     "INSERT INTO Vouchers_D (EntryNo, AcCode,VoucherNo,Particulars,Debit,Credit) VALUES ('${numsentry.toString().padLeft(5, "0")}', '${credittercontroller.text}','${journallist_h[number].voucherNo.toString().trim()}','${particularcontroller.text.toString().trim()}','${amountcontroller.text}','${debittercontroller.text}');");
                                                      await getdata2();
                                                    },
                                                    child: Text(
                                                      "Post",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    color: Colors.red,
                                                  )),
                                                )),
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                ))
                          ]))),
                ),
              ));
  }

  DataTable _createDataTable(double wid) {
    return DataTable(
        headingRowHeight: 30,
        headingRowColor:
            MaterialStateColor.resolveWith((states) => Colors.black12),
        columnSpacing: 20,
        columns: _createColumns(wid),
        rows: _createRows());
  }

  List<DataColumn> _createColumns(double wid) {
    return [
      DataColumn(
          label: SizedBox(
        width: wid * .1,
        child: const Text('Code',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      )),
      DataColumn(
          label: SizedBox(
        width: wid * .2,
        child: const Text('Description',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      )),
      DataColumn(
          label: SizedBox(
        width: wid * .2,
        child: const Text('Particular',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      )),
      DataColumn(
          label: SizedBox(
        width: wid * .1,
        child: const Text('Qty',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      )),
    ];
  }

  List<DataRow> _createRows() {
    return Filterjournallist_d.map((e) => DataRow(cells: [
          DataCell(Text(e.iCode.toString() == "" ? "---" : e.iCode.toString())),
          DataCell(Text(e.iCode.toString() == "" ? "---" : e.iCode.toString())),
          DataCell(Text(e.particulars.toString())),
          DataCell(Text(e.qty.toString())),
        ])).toList();
  }

  TextEditingController voucherscontroller = TextEditingController();
  TextEditingController remarkscontroller = TextEditingController();

  alertDialogsss() {
    TextEditingController updateremarkscontroller = TextEditingController();
    TextEditingController voucherscontrollers = TextEditingController();

    TextEditingController dateupdatecontroller = TextEditingController();

    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            actions: [
              MaterialButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                color: Colors.red,
                child: Text(
                  entrynumber
                      .toString()
                      .padLeft(5, "0")
                      .toString()
                      .length
                      .toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              MaterialButton(
                onPressed: () async {
                  final res = await apicall(
                      "INSERT INTO Vouchers_H (EntryNo, VoucherNo,Particulars,Dated,Amount,ConvRate,JvNature) VALUES ('${entrynumber.toString().padLeft(5, "0")}', '${voucherscontrollers.text}','${updateremarkscontroller.text.toString().trim()}','${dateupdatecontroller.text} 00:00:00.000','0','1','ACTUAL');");
                  if (res.body.toString() == "[]") {
                    setState(() {
                      getdata();
                    });
                    Navigator.pop(context);
                  }
                },
                color: Colors.green,
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
            content: SizedBox(
                child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildwidgetextraa(voucherscontrollers, "VoucherNo", "", false,
                      (value) {}, 6),
                  const SizedBox(
                    height: 5,
                  ),
                  buildwidgetextra(dateupdatecontroller, "Date", voucherdateadd,
                      false, (value) {}),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: updateremarkscontroller,
                    minLines: 5,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black38, width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 0.5),
                      ),
                      hintText: "Remarks",
                      labelStyle: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  )
                ],
              ),
            )),
          );
        }));
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
                                      credittercontroller.text =
                                          users.acCode.toString().trim();
                                    });
                                    print(credittercontroller.text);
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
}

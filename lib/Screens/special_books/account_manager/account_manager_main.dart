import 'dart:async';

import 'package:bm/Screens/special_books/account_manager/account_manager_model.dart';
import 'package:bm/Screens/special_books/account_manager/account_manager_service.dart';
import 'package:bm/Screens/special_books/accounts_details_pdf.dart';
import 'package:bm/main.dart';

import 'package:bm/widgets.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'dart:convert' as convert;

import 'package:flutter/material.dart';

class AccountManagerMain extends StatefulWidget {
  const AccountManagerMain({super.key});

  @override
  State<AccountManagerMain> createState() => _AccountManagerMainState();
}

class _AccountManagerMainState extends State<AccountManagerMain> {
  //service called here
  final Service _service = Service();

  //lists of main account list
  List<account_manager_model> accountlistusers = [];
  List<account_manager_model> filteraccountlist = [];
  List<int?> totalbalancelist = [];
  List<details_model> dataresult = [];
  var data = [];

  //

  var detailsdata = [];
  List<details_model> detailsdataresult = [];

  //account type list

  List<AcTypeModel> typelist = [];

  //filter codes
  List<account_manager_model> filterlistcode = [];

  //textediting controllers
  TextEditingController searchcontroller = TextEditingController();
  TextEditingController codecontroller = TextEditingController();
  TextEditingController accountnamecontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController $controller = TextEditingController();
  TextEditingController amountcontroller = TextEditingController();

  //boolen for add screen
  bool addScreen = false;

  //call data of account main and type

  Future<void> getdata() async {
    typelist = await _service.accountType();
    accountlistusers = await _service.getallassetscounts();

    filteraccountlist = accountlistusers;

    final selectresponse = await apicall(
        "SELECT Accounts.AcName, Ac_Details.Contact, Ac_Details.Telephone, Ac_Details.Fax, Ac_Details.City  FROM Accounts INNER JOIN Ac_Details ON Accounts.AcCode=Ac_Details.AcCode;");
    detailsdata = convert.jsonDecode(selectresponse.body);
    detailsdataresult =
        detailsdata.map((e) => details_model.fromJson(e)).toList();

    setState(() {});
  }

  //call data for filtering codes

  Future getdatacode() async {
    filterlistcode =
        await _service.getcodes(_cnt.dropDownValue!.value.toString());

    setState(() {});
  }

  var dateTime = DateTime.parse(DateTime.now().toString());

  //controller of dropdown

  late SingleValueDropDownController _cnt;

  //string var
  String code1 = "";
  num codestructure = 00000;
  String codes2 = "";

  //init state
  Timer? timer;

  @override
  void initState() {
    _cnt = SingleValueDropDownController();
    getdata();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var dateformate1 = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
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
                                  onPressed: () {},
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
                              SizedBox(
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AccountsdetailsPdf(
                                          invoice: detailsdataresult,
                                        ),
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
                                        "Print Account Details",
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
                              Expanded(child: Container()),
                              Expanded(
                                  child: TextField(
                                controller: searchcontroller,
                                onChanged: ((value) {
                                  setState(() {
                                    filteraccountlist = accountlistusers
                                        .where((element) => element.acName
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
                            child: filteraccountlist.isEmpty
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: _createDataTable(
                                                filteraccountlist))
                                      ],
                                    ),
                                  )),
                        Container(
                          height: 40,
                          color: Colors.red,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 100, right: 100),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Total Balance:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  filteraccountlist
                                      .fold(
                                          0,
                                          (previousValue, element) =>
                                              previousValue +
                                              element.opBalance!)
                                      .toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
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
                          height: 15,
                        ),
                        Expanded(
                            child: SizedBox(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                      children: [
                                        namewidget("A/C Type"),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 12, right: 12),
                                          child: DropDownTextField(
                                            controller: _cnt,
                                            dropDownItemCount: typelist.length,
                                            dropDownList: acTypelist(),
                                            onChanged: ((value) async {
                                              await getdatacode();

                                              final String nums = Characters(
                                                      filterlistcode.isEmpty
                                                          ? "00000000000"
                                                          : filterlistcode
                                                              .last.acCode
                                                              .toString())
                                                  .takeLast(5)
                                                  .string;
                                              num codenumss =
                                                  num.parse(nums.toString()) +
                                                      1;
                                              setState(() {
                                                code1 = _cnt
                                                    .dropDownValue!.value
                                                    .toString();
                                                codes2 = codenumss.toString();
                                              });
                                            }),
                                            textFieldDecoration:
                                                const InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black38,
                                                    width: 0.5),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 0.5),
                                              ),
                                              labelStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                                    Expanded(
                                        child: Column(
                                      children: [
                                        namewidget("A/C Code"),
                                        textfieldwidget(
                                            codecontroller
                                              ..text =
                                                  "${code1.trim()}${codes2.toString().padLeft(5, "0").trim()}",
                                            "",
                                            ((value) {}),
                                            1,
                                            1,
                                            15,
                                            true)
                                      ],
                                    )),
                                  ],
                                ),
                                namewidget("A/C Name"),
                                textfieldwidget(accountnamecontroller, "",
                                    ((value) {}), 1, 1, 30, false),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                      children: [
                                        namewidget("b/F Date"),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 12, right: 12),
                                          child: TextField(
                                            readOnly: true,
                                            controller: datecontroller
                                              ..text = dateformate1,
                                            onChanged: ((value) {}),
                                            decoration: const InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black38,
                                                    width: 0.5),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 0.5),
                                              ),
                                              labelStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                                    Expanded(
                                        child: Column(
                                      children: [
                                        namewidget("\$"),
                                        textfieldwidget(
                                            $controller..text = "1.00",
                                            "",
                                            ((value) {}),
                                            1,
                                            1,
                                            10,
                                            false)
                                      ],
                                    )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                namewidget("B/F Amount"),
                                textfieldwidget(amountcontroller, "",
                                    ((value) {}), 1, 1, 15, false),
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                            final response = await apicall(
                                                "INSERT INTO Accounts (AcCode, TypeCode, AcName, OpDate, OpBalance, ConvRate,Balance, PrevBal) VALUES ('${codecontroller.text}', '${_cnt.dropDownValue!.value.toString().trim()}' , '${accountnamecontroller.text}', '$dateformate1 00:00:00.000', '${amountcontroller.text}' , '${$controller.text}', '${amountcontroller.text}', '0' );");
                                            codecontroller.clear();
                                            _cnt.clearDropDown();
                                            accountnamecontroller.clear();
                                            amountcontroller.clear();
                                            setState(() {
                                              getdata();
                                              addScreen = false;
                                            });

                                            print(response.body.toString());
                                          },
                                          color: Colors.green,
                                          child: Row(
                                            children: const [
                                              Text(
                                                "Post",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                          ),
                        ))
                      ],
                    ),
                  )),
                ),
              ));
  }

  //datatable widgets
  DataTable _createDataTable(List<account_manager_model> list) {
    return DataTable(
        columnSpacing: 40, columns: _createColumns(), rows: _createRows(list));
  }

  //datatable head list
  List<DataColumn> _createColumns() {
    return [
      const DataColumn(
          label: Text('Code',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text('A/C Name',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text('A/C Type',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text('Balance',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text('Action',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
    ];
  }

  //datatable rows list , can ganerate from api future lists
  List<DataRow> _createRows(List<account_manager_model> list) {
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
                  DataCell(Text(e.acCode.toString())),
                  DataCell(Text(e.acName.toString())),
                  DataCell(Text(e.typeCode.toString())),
                  DataCell(Text(e.opBalance.toString())),
                  DataCell(Row(
                    children: [
                      IconButton(
                          onPressed: () async {
                            final responsee = await apicall(
                                "select * from Ac_Details where AcCode = '${e.acCode}'");
                            if (responsee.body.toString() == "[]") {
                              await apicall(
                                  "INSERT INTO Ac_Details (AcCode) VALUES ('${e.acCode}');");
                              final selectresponse = await apicall(
                                  "select * from Ac_Details where AcCode = '${e.acCode}'");
                              data = convert.jsonDecode(selectresponse.body);
                              dataresult = data
                                  .map((e) => details_model.fromJson(e))
                                  .toList();
                              AlertDialogsss(dataresult, e.acName.toString());
                            } else {
                              data = convert.jsonDecode(responsee.body);
                              dataresult = data
                                  .map((e) => details_model.fromJson(e))
                                  .toList();
                              AlertDialogsss(dataresult, e.acName.toString());
                            }
                          },
                          icon: const Icon(
                            Icons.view_agenda,
                            color: Colors.blue,
                          )),
                      IconButton(
                          onPressed: () async {},
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          )),
                      IconButton(
                          onPressed: () async {
                            final searchresponse = await apicall(
                                "select * from Ac_Details where AcCode = '${e.acCode}'");
                            final searchresponse2 = await apicall(
                                "select * from LiabCap where AcCode = '${e.acCode}'");

                            if (searchresponse.body.toString() == "[]" &&
                                searchresponse2.body.toString() == "[]") {
                              await apicall(
                                  "DELETE FROM Accounts WHERE AcCode='${e.acCode}';");
                              setState(() {
                                getdata();
                              });
                            } else {
                              final responsee = await apicall(
                                  "DELETE FROM Accounts WHERE AcCode='${e.acCode}';");
                              showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return AlertDialog(
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Ok"))
                                        ],
                                        content: SizedBox(
                                          width: 180,
                                          height: 180,
                                          child:
                                              Text(responsee.body.toString()),
                                        ));
                                  }));
                            }
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

  namewidget(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  List<DropDownValueModel> acTypelist() {
    return typelist
        .map((e) =>
            DropDownValueModel(name: e.acType.toString(), value: e.typeCode))
        .toList();
  }

  AlertDialogsss(List<details_model> model, String name) {
    TextEditingController namecontroller1 = TextEditingController();
    TextEditingController addresscontroller1 = TextEditingController();
    TextEditingController addresscontroller2 = TextEditingController();
    TextEditingController citycontroller = TextEditingController();
    TextEditingController contactcontroller = TextEditingController();
    TextEditingController phonecontroller1 = TextEditingController();
    TextEditingController faxcontroller = TextEditingController();
    TextEditingController creditcontroller1 = TextEditingController();
    TextEditingController salesmancontroller1 = TextEditingController();
    TextEditingController emailcontroller1 = TextEditingController();

    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            actions: [
              MaterialButton(
                onPressed: () async {
                  await apicall(
                      "DELETE FROM Ac_Details WHERE AcCode='${model.first.acCode}';");
                  Navigator.pop(context);
                },
                color: Colors.red,
                child: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              MaterialButton(
                onPressed: () async {
                  final responsee = await apicall(
                      "UPDATE Ac_Details SET Address1 = '${addresscontroller1.text}', Address2= '${addresscontroller2.text}', City = '${citycontroller.text}', Telephone = '${phonecontroller1.text}' , Fax = '${faxcontroller.text}' , Contact = '${contactcontroller.text}' , Credit = '${creditcontroller1.text}' , Remarks = '${emailcontroller1.text}'  , SaleMan = '${salesmancontroller1.text}' WHERE AcCode = '${model.first.acCode}';");

                  if (responsee.body.toString() == "[]") {
                    Navigator.pop(context);
                  } else {
                    print(responsee.body.toString());
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
                width: 400,
                height: 500,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildwidgetextra(
                          namecontroller1, "Name:", name, true, (value) {}),
                      buildwidgetextra(
                          addresscontroller1,
                          "Address1:",
                          model.first.address1.toString().trim(),
                          false,
                          (value) {}),
                      buildwidgetextra(
                          addresscontroller2,
                          "Address2:",
                          model.first.address2.toString().trim(),
                          false,
                          (value) {}),
                      buildwidgetextra(
                          phonecontroller1,
                          "Phone:",
                          model.first.telephone.toString().trim(),
                          false,
                          (value) {}),
                      buildwidgetextra(
                          contactcontroller,
                          "Contact",
                          model.first.contact.toString().trim(),
                          false,
                          (value) {}),
                      buildwidgetextra(
                          emailcontroller1,
                          "Email:",
                          model.first.remarks.toString().trim(),
                          false,
                          (value) {}),
                      buildwidgetextra(
                          salesmancontroller1,
                          "SalesMan:",
                          model.first.saleMan.toString().trim(),
                          false,
                          (value) {}),
                      buildwidgetextra(faxcontroller, "Fax:",
                          model.first.fax.toString().trim(), false, (value) {}),
                      buildwidgetextra(
                          creditcontroller1,
                          "credit:",
                          model.first.credit.toString().trim(),
                          false,
                          (value) {})
                    ],
                  ),
                )),
          );
        }));
  }
}

namewidget(String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
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

buildwidgetextraa(TextEditingController controller, String title, String data,
    bool bool, void Function(value), int maxlength) {
  return Row(
    children: [
      Expanded(flex: 2, child: Text(title)),
      Expanded(
          flex: 8,
          child: textfieldwidgetmaxlength(
              controller..text = data, "", Function, 1, 1, maxlength, bool))
    ],
  );
}

import 'package:bm/Screens/special_books/account_manager/account_manager_model.dart';
import 'package:bm/Screens/special_books/account_manager/account_manager_service.dart';
import 'package:bm/main.dart';
import 'package:flutter/material.dart';

class ChartsOfAccountMain extends StatefulWidget {
  const ChartsOfAccountMain({super.key});

  @override
  State<ChartsOfAccountMain> createState() => _ChartsOfAccountMainState();
}

class _ChartsOfAccountMainState extends State<ChartsOfAccountMain> {
  List<AcTypeModel> listu = [];
  List<AcTypeModel> filterlistu = [];
  final Service _service = Service();
  final TextEditingController _codecontroller = TextEditingController();
  final TextEditingController _desccontroller = TextEditingController();
  final TextEditingController _editcodecontroller = TextEditingController();
  final TextEditingController _editdesccontroller = TextEditingController();
  String code = "";
  String description = "";

  Future<void> getdata() async {
    listu = await _service.accountType();
    filterlistu = listu;
    setState(() {});
  }

  @override
  void initState() {
    getdata();
    // TODO: implement initState
    super.initState();
  }

  //service called here
  String khan = "";

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
                      ],
                    ),
                  )),
                  Expanded(
                      child: Row(
                    children: [
                      Expanded(
                          child: filterlistu.isEmpty
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : SingleChildScrollView(
                                  child: Column(
                                    children: [_createDataTable()],
                                  ),
                                )),
                      Expanded(
                          child: Card(
                        elevation: 10,
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              namewidget("Code"),
                              textfieldwidget(
                                  _codecontroller, "", (value) {}, 1, 1, 3),
                              namewidget("Description"),
                              textfieldwidget(
                                  _desccontroller, "", (value) {}, 5, 5, 20),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  errormessage2.isEmpty ? "" : errormessage2,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: SizedBox(
                                      child: MaterialButton(
                                        onPressed: () async {
                                          if (_codecontroller.text.isNotEmpty &&
                                              _desccontroller.text.isNotEmpty) {
                                            final response = await apicall(
                                                "INSERT INTO Ac_Chart (TypeCode, AcType) VALUES ('${_codecontroller.text.toUpperCase()}', '${_desccontroller.text}');");

                                            if (response.body.toString() ==
                                                "[]") {
                                              setState(() {
                                                errormessage2 = "";
                                                getdata();
                                              });
                                              _codecontroller.clear();
                                              _desccontroller.clear();
                                            } else {
                                              setState(() {
                                                errormessage2 =
                                                    "cannot insert duplicate code";
                                              });
                                            }
                                          } else {
                                            setState(() {
                                              errormessage2 =
                                                  "Please Enter Code and Description";
                                            });
                                          }
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
                      )),
                    ],
                  ))
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
          label: Text('Code',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text('Description',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
      const DataColumn(
          label: Text('actions',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
    ];
  }

  //datatable rows list , can ganerate from api future lists
  List<DataRow> _createRows() {
    return filterlistu
        .map((e) => DataRow(
                color: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  // Even rows will have a grey color.
                  if (filterlistu.indexOf(e) % 2 == 0) {
                    return Colors.black12;
                  }
                  return Colors
                      .white; // Use default value for other states and odd rows.
                }),
                cells: [
                  DataCell(Text(e.acType.toString())),
                  DataCell(Text(e.typeCode.toString())),
                  DataCell(Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              code = e.typeCode!.trim().toString();
                              description = e.acType!.trim().toString();
                              errormessage = "";
                            });
                            showdialogsbox();
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          )),
                      IconButton(
                          onPressed: () async {
                            await apicall(
                                "DELETE FROM Ac_Chart WHERE TypeCode='${e.typeCode}';");
                            setState(() {
                              getdata();
                            });
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

  textfieldwidget(TextEditingController controller, String textlabel,
      void Function(value), int lines, int lines2, int maxlength) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: TextField(
        maxLength: maxlength,
        controller: controller,
        minLines: lines,
        maxLines: lines2,
        onChanged: Function,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38, width: 0.5),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 0.5),
          ),
          label: Text(textlabel),
          labelStyle: const TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
    );
  }

  showdialogsbox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              title: const Text("Edit"),
              content: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    namewidget("Code"),
                    textfieldwidget(_editcodecontroller..text = code, "",
                        (value) {}, 2, 2, 3),
                    namewidget("Description"),
                    textfieldwidget(_editdesccontroller..text = description, "",
                        (value) {}, 2, 2, 25),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      errormessage.isEmpty ? "" : errormessage,
                      style: const TextStyle(color: Colors.red),
                    )
                  ],
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () async {
                          final response = await apicall(
                              "UPDATE Ac_Chart SET TypeCode = '${_editcodecontroller.text.trim()}', AcType= '${_editdesccontroller.text.trim()}' WHERE TypeCode = '$code';");

                          if (response.body.toString() == "[]") {
                            setState(() {
                              getdata();
                            });
                            Navigator.pop(context);
                          } else {
                            setState(() {
                              errormessage = "Cannot Insert Duplicate Code";
                            });
                          }
                        },
                        child: const Text("Update"))
                  ],
                )
              ],
            );
          });
        });
  }

  String errormessage = "";
  String errormessage2 = "";
}

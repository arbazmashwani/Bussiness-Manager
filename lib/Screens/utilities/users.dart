import 'dart:math';

import 'package:bm/Screens/authentication/admin_model.dart';
import 'package:bm/Screens/special_books/account_manager/account_manager_main.dart';
import 'package:bm/main.dart';
import 'package:bm/responsive.dart';

import 'package:flutter/material.dart';
import 'dart:convert' as convert;


class UsersdataPage extends StatefulWidget {
  const UsersdataPage({super.key});

  @override
  State<UsersdataPage> createState() => _UsersdataPageState();
}

class _UsersdataPageState extends State<UsersdataPage> {
  var data = [];
  var data2 = [];
  List<AdminModel> adminlist = [];
  List<AdminModel> searchadminlist = [];

  List<bool> _selected = List.generate(10, (i) => false);

  Future<void> getadmindata() async {
    final response = await apicall("select * from users");
    data = convert.jsonDecode(response.body);
    adminlist = data.map((e) => AdminModel.fromJson(e)).toList();
    setState(() {});
  }

  Future<void> getspecificadmindata(String username) async {
    final response =
        await apicall("select * from users where UserName = '$username'");
    data2 = convert.jsonDecode(response.body);
    searchadminlist = data2.map((e) => AdminModel.fromJson(e)).toList();
    setState(() {});
  }

  @override
  void initState() {
    getadmindata();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Responsive.isMobile(context) && username.isNotEmpty
              ? Container()
              : Expanded(
                  flex: Responsive.isMobile(context) && username.isNotEmpty
                      ? 3
                      : 5,
                  child: Card(
                      child: adminlist.isEmpty
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Card(
                              elevation: 10,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            MaterialButton(
                                              color: Colors.red,
                                              onPressed: () {},
                                              child: Row(
                                                children: const [
                                                  Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                    "ADD",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1000,
                                      child: ListView.builder(
                                          itemCount: adminlist.length,
                                          itemBuilder: ((context, index) {
                                            var pictureslist = [
                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvxDrCR5SfO2zzeBNLF9U9xbjlC8-ToAA68g&usqp=CAU',
                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdtSqFR8a-XFmYunMn04kbV71FqDulC3d1Qw&usqp=CAU',
                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSv00m-RB7TtdPHzzer0T4rTkqkbEkmov0wUg&usqp=CAU',
                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT60MyBMkcLfLBsjr8HyLmjKrCiPyFzyA-4Q&usqp=CAU',
                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIC_5e6KT8qXd9ZGNFgDPrDJiqsKMQ37OJbA&usqp=CAU'
                                            ];
                                            AdminModel users = adminlist[index];
                                            String getRandom() {
                                              const ch =
                                                  'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
                                              Random r = Random();
                                              return String.fromCharCodes(
                                                  Iterable.generate(
                                                      users.password!
                                                          .toString()
                                                          .trim()
                                                          .length,
                                                      (_) => ch.codeUnitAt(
                                                          r.nextInt(
                                                              ch.length))));
                                            }

                                            final String obscuretext =
                                                getRandom();

                                            return Card(
                                              elevation: 5,
                                              child: ListTile(
                                                leading: CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      (pictureslist.toList()
                                                            ..shuffle())
                                                          .first
                                                          .toString()),
                                                ),
                                                tileColor: _selected[index]
                                                    ? Colors.grey[300]
                                                    : null,
                                                onTap: () async {
                                                  getspecificadmindata(users
                                                      .userName
                                                      .toString());
                                                  setState(() {
                                                    _selected = List.filled(
                                                        _selected.length, false,
                                                        growable: true);
                                                    _selected[index] =
                                                        !_selected[index];
                                                    username = users.userName
                                                        .toString()
                                                        .trim();
                                                    password = users.password
                                                        .toString()
                                                        .trim();
                                                  });
                                                },
                                                subtitle: Text(obscuretext),
                                                title: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(users.userName
                                                        .toString()),
                                                    Row(
                                                      children: [
                                                        IconButton(
                                                            onPressed: () {},
                                                            icon: const Icon(
                                                              Icons.edit,
                                                              color:
                                                                  Colors.green,
                                                            )),
                                                        IconButton(
                                                            onPressed: () {},
                                                            icon: const Icon(
                                                              Icons.delete,
                                                              color: Colors.red,
                                                            )),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          })),
                                    )
                                  ],
                                ),
                              )))),
          Expanded(
              flex: username.isEmpty ? 2 : 7,
              child: Container(
                  child: SingleChildScrollView(
                child: Column(
                  children: searchadminlist.isEmpty
                      ? []
                      : List.generate(1, (index) {
                          AdminModel users2 = searchadminlist[index];
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 4,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              namewidget("Daily Books"),
                                              listtilewidget(
                                                  "paypal book",

                                                  //pbook view
                                                  users2.pBookV!,
                                                  (bool) {
                                                    setState(() {
                                                      users2.pBookV =
                                                          !users2.pBookV!;
                                                    });
                                                    apicallstoupdatepermission(
                                                        "PBook_V",
                                                        users2.pBookV!);
                                                  },
                                                  //pbook i
                                                  users2.pBookI!,
                                                  (bool) {
                                                    setState(() {
                                                      users2.pBookI =
                                                          !users2.pBookI!;
                                                    });
                                                    apicallstoupdatepermission(
                                                        "PBook_I",
                                                        users2.pBookI!);
                                                  },
                                                  //pbook e
                                                  users2.pBookE!,
                                                  (bool) {
                                                    setState(() {
                                                      users2.pBookE =
                                                          !users2.pBookE!;
                                                    });
                                                    apicallstoupdatepermission(
                                                        "PBook_E",
                                                        users2.pBookE!);
                                                  },
                                                  //pbook d
                                                  users2.pBookD!,
                                                  (bool) {
                                                    setState(() {
                                                      users2.pBookD =
                                                          !users2.pBookD!;
                                                    });
                                                    apicallstoupdatepermission(
                                                        "PBook_D",
                                                        users2.pBookD!);
                                                  }),
                                              // transfer book //

                                              listtilewidget(
                                                  "Transfer book",

                                                  //transfer view
                                                  users2.tBookV!,
                                                  (bool) {
                                                    setState(() {
                                                      users2.tBookV =
                                                          !users2.tBookV!;
                                                    });
                                                    apicallstoupdatepermission(
                                                        "TBook_V",
                                                        users2.tBookV!);
                                                  },
                                                  //TRA BOOK i
                                                  users2.tBookI!,
                                                  (bool) {
                                                    setState(() {
                                                      users2.tBookI =
                                                          !users2.tBookI!;
                                                    });
                                                    apicallstoupdatepermission(
                                                        "TBook_I",
                                                        users2.tBookI!);
                                                  },
                                                  //TRANS BOOK e
                                                  users2.tBookE!,
                                                  (bool) {
                                                    setState(() {
                                                      users2.tBookE =
                                                          !users2.tBookE!;
                                                    });
                                                    apicallstoupdatepermission(
                                                        "TBook_E",
                                                        users2.tBookE!);
                                                  },
                                                  //TRANS BOOK d
                                                  users2.tBookD!,
                                                  (bool) {
                                                    setState(() {
                                                      users2.tBookD =
                                                          !users2.tBookD!;
                                                    });
                                                    apicallstoupdatepermission(
                                                        "TBook_D",
                                                        users2.tBookD!);
                                                  }),

                                              //SALE BILL BOOK

                                              listtilewidget(
                                                  "Sale Bill Book",

                                                  //pbook view
                                                  users2.sBookV!,
                                                  (bool) {
                                                    setState(() {
                                                      users2.sBookV =
                                                          !users2.sBookV!;
                                                    });
                                                    apicallstoupdatepermission(
                                                        "SBook_V",
                                                        users2.sBookV!);
                                                  },
                                                  //pbook i
                                                  users2.sBookI!,
                                                  (bool) {
                                                    setState(() {
                                                      users2.sBookI =
                                                          !users2.sBookI!;
                                                    });
                                                    apicallstoupdatepermission(
                                                        "SBook_I",
                                                        users2.sBookI!);
                                                  },
                                                  //pbook e
                                                  users2.sBookE!,
                                                  (bool) {
                                                    setState(() {
                                                      users2.sBookE =
                                                          !users2.sBookE!;
                                                    });
                                                    apicallstoupdatepermission(
                                                        "SBook_E",
                                                        users2.sBookE!);
                                                  },
                                                  //pbook d
                                                  users2.sBookD!,
                                                  (bool) {
                                                    setState(() {
                                                      users2.sBookD =
                                                          !users2.sBookD!;
                                                    });
                                                    apicallstoupdatepermission(
                                                        "SBook_D",
                                                        users2.sBookD!);
                                                  }),

                                              //receipt book //
                                              listtilewidget(
                                                  "Receipt book",

                                                  //pbook view
                                                  users2.rBookV!,
                                                  (bool) {
                                                    setState(() {
                                                      users2.rBookV =
                                                          !users2.rBookV!;
                                                    });
                                                    apicallstoupdatepermission(
                                                        "RBook_V",
                                                        users2.rBookV!);
                                                  },
                                                  //pbook i
                                                  users2.rBookI!,
                                                  (bool) {
                                                    setState(() {
                                                      users2.rBookI =
                                                          !users2.rBookI!;
                                                    });
                                                    apicallstoupdatepermission(
                                                        "RBook_I",
                                                        users2.rBookI!);
                                                  },
                                                  //pbook e
                                                  users2.rBookE!,
                                                  (bool) {
                                                    setState(() {
                                                      users2.rBookE =
                                                          !users2.rBookE!;
                                                    });
                                                    apicallstoupdatepermission(
                                                        "RBook_E",
                                                        users2.rBookE!);
                                                  },
                                                  //pbook d
                                                  users2.rBookD!,
                                                  (bool) {
                                                    setState(() {
                                                      users2.rBookD =
                                                          !users2.rBookD!;
                                                    });
                                                    apicallstoupdatepermission(
                                                        "RBook_D",
                                                        users2.rBookD!);
                                                  }),

                                              //payment book

                                              listtilewidget(
                                                  "Payment book",

                                                  //pbook view
                                                  users2.payBookV!,
                                                  (bool) {
                                                    setState(() {
                                                      users2.payBookV =
                                                          !users2.payBookV!;
                                                    });
                                                    apicallstoupdatepermission(
                                                        "PayBook_V",
                                                        users2.payBookV!);
                                                  },
                                                  //pbook i
                                                  users2.payBookI!,
                                                  (bool) {
                                                    setState(() {
                                                      users2.payBookI =
                                                          !users2.payBookI!;
                                                    });
                                                    apicallstoupdatepermission(
                                                        "PayBook_I",
                                                        users2.payBookI!);
                                                  },
                                                  //pbook e
                                                  users2.payBookE!,
                                                  (bool) {
                                                    setState(() {
                                                      users2.payBookE =
                                                          !users2.payBookE!;
                                                    });
                                                    apicallstoupdatepermission(
                                                        "PayBook_E",
                                                        users2.payBookE!);
                                                  },
                                                  //pbook d
                                                  users2.payBookD!,
                                                  (bool) {
                                                    setState(() {
                                                      users2.payBookD =
                                                          !users2.payBookD!;
                                                    });
                                                    apicallstoupdatepermission(
                                                        "PayBook_D",
                                                        users2.payBookD!);
                                                  }),

                                              //journal vouchers//

                                              listtilewidget(
                                                  "Journal Vouchers",

                                                  //pbook view
                                                  users2.jBookV!,
                                                  (bool) {
                                                    setState(() {
                                                      users2.jBookV =
                                                          !users2.jBookV!;
                                                    });
                                                    apicallstoupdatepermission(
                                                        "JBook_V",
                                                        users2.jBookV!);
                                                  },
                                                  //pbook i
                                                  users2.jBookI!,
                                                  (bool) {
                                                    setState(() {
                                                      users2.jBookI =
                                                          !users2.jBookI!;
                                                    });
                                                    apicallstoupdatepermission(
                                                        "JBook_I",
                                                        users2.jBookI!);
                                                  },
                                                  //pbook e
                                                  users2.jBookE!,
                                                  (bool) {
                                                    setState(() {
                                                      users2.jBookE =
                                                          !users2.jBookE!;
                                                    });
                                                    apicallstoupdatepermission(
                                                        "JBook_E",
                                                        users2.jBookE!);
                                                  },
                                                  //pbook d
                                                  users2.jBookD!,
                                                  (bool) {
                                                    setState(() {
                                                      users2.jBookD =
                                                          !users2.jBookD!;
                                                    });
                                                    apicallstoupdatepermission(
                                                        "JBook_D",
                                                        users2.jBookD!);
                                                  }),

                                              namewidget("Utilities"),
                                              listtilewidgetsingle(
                                                  "Add/Remove Users",
                                                  users2.addRemoveUsers!, (v) {
                                                setState(() {
                                                  users2.addRemoveUsers =
                                                      !users2.addRemoveUsers!;
                                                });
                                                apicallstoupdatepermission(
                                                    "AddRemoveUsers",
                                                    users2.addRemoveUsers!);
                                              }),
                                              listtilewidgetsingle(
                                                  "Backup/Restore",
                                                  users2.dataBackup!,
                                                  (v) {})
                                            ],
                                          ),
                                        )),
                                    Expanded(
                                        flex: 6,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              namewidget("Special Books"),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: Column(
                                                    children: [
                                                      listtilewidgetsingle(
                                                          "Assets Ledger",
                                                          users2.assets!, (v) {
                                                        setState(() {
                                                          users2.assets =
                                                              !users2.assets!;
                                                        });
                                                        apicallstoupdatepermission(
                                                            "Assets",
                                                            users2.assets!);
                                                      }),
                                                      //
                                                      listtilewidgetsingle(
                                                          "Liabilities Ledger",
                                                          users2.liabilities!,
                                                          (v) {
                                                        setState(() {
                                                          users2.liabilities =
                                                              !users2
                                                                  .liabilities!;
                                                        });
                                                        apicallstoupdatepermission(
                                                            "Liabilities",
                                                            users2
                                                                .liabilities!);
                                                      }),
                                                      //
                                                      listtilewidgetsingle(
                                                          "Capital Ledgers",
                                                          users2.capital!, (v) {
                                                        setState(() {
                                                          users2.capital =
                                                              !users2.capital!;
                                                        });
                                                        apicallstoupdatepermission(
                                                            "Capital",
                                                            users2.capital!);
                                                      }),
                                                      //
                                                      listtilewidgetsingle(
                                                          "Expense Ledger",
                                                          users2.expenses!,
                                                          (v) {
                                                        setState(() {
                                                          users2.expenses =
                                                              !users2.expenses!;
                                                        });
                                                        apicallstoupdatepermission(
                                                            "Expenses",
                                                            users2.expenses!);
                                                      }),
                                                      //
                                                      listtilewidgetsingle(
                                                          "Revenue Ledger",
                                                          users2.revenue!, (v) {
                                                        setState(() {
                                                          users2.revenue =
                                                              !users2.revenue!;
                                                        });
                                                        apicallstoupdatepermission(
                                                            "Revenue",
                                                            users2.revenue!);
                                                      }),
                                                      //stock
                                                      listtilewidgetsingle(
                                                          "Stock Ledger",
                                                          users2.stock!, (v) {
                                                        setState(() {
                                                          users2.stock =
                                                              !users2.stock!;
                                                        });
                                                        apicallstoupdatepermission(
                                                            "Stock",
                                                            users2.stock!);
                                                      }),
                                                    ],
                                                  )),
                                                  Expanded(
                                                      child: Column(
                                                    children: [
                                                      listtilewidget(
                                                          "Brand/category/salePerson/godown",

                                                          //pbook view
                                                          users2.chartBookV!,
                                                          (bool) {
                                                            setState(() {
                                                              users2.chartBookV =
                                                                  !users2
                                                                      .chartBookV!;
                                                            });
                                                            apicallstoupdatepermission(
                                                                "ChartBook_V",
                                                                users2
                                                                    .chartBookV!);
                                                          },
                                                          //pbook i
                                                          users2.chartBookI!,
                                                          (bool) {
                                                            setState(() {
                                                              users2.chartBookI =
                                                                  !users2
                                                                      .chartBookI!;
                                                            });
                                                            apicallstoupdatepermission(
                                                                "ChartBook_I",
                                                                users2
                                                                    .chartBookI!);
                                                          },
                                                          //pbook e
                                                          users2.chartBookE!,
                                                          (bool) {
                                                            setState(() {
                                                              users2.chartBookE =
                                                                  !users2
                                                                      .chartBookE!;
                                                            });
                                                            apicallstoupdatepermission(
                                                                "ChartBook_E",
                                                                users2
                                                                    .chartBookE!);
                                                          },
                                                          //pbook d
                                                          users2.chartBookD!,
                                                          (bool) {
                                                            setState(() {
                                                              users2.chartBookD =
                                                                  !users2
                                                                      .chartBookD!;
                                                            });
                                                            apicallstoupdatepermission(
                                                                "ChartBook_D",
                                                                users2
                                                                    .chartBookD!);
                                                          }),
                                                      //
                                                      listtilewidget(
                                                          "Accounts Manager",

                                                          //pbook view
                                                          users2.accBookV!,
                                                          (bool) {
                                                            setState(() {
                                                              users2.accBookV =
                                                                  !users2
                                                                      .accBookV!;
                                                            });
                                                            apicallstoupdatepermission(
                                                                "AccBook_V",
                                                                users2
                                                                    .accBookV!);
                                                          },
                                                          //pbook i
                                                          users2.accBookI!,
                                                          (bool) {
                                                            setState(() {
                                                              users2.accBookI =
                                                                  !users2
                                                                      .accBookI!;
                                                            });
                                                            apicallstoupdatepermission(
                                                                "AccBook_I",
                                                                users2
                                                                    .accBookI!);
                                                          },
                                                          //pbook e
                                                          users2.accBookE!,
                                                          (bool) {
                                                            setState(() {
                                                              users2.accBookE =
                                                                  !users2
                                                                      .accBookE!;
                                                            });
                                                            apicallstoupdatepermission(
                                                                "AccBook_E",
                                                                users2
                                                                    .accBookE!);
                                                          },
                                                          //pbook d
                                                          users2.accBookD!,
                                                          (bool) {
                                                            setState(() {
                                                              users2.accBookD =
                                                                  !users2
                                                                      .accBookD!;
                                                            });
                                                            apicallstoupdatepermission(
                                                                "AccBook_D",
                                                                users2
                                                                    .accBookD!);
                                                          }),
                                                      //
                                                      listtilewidget(
                                                          "Stock Vouchers",

                                                          //pbook view
                                                          users2.stkBookV!,
                                                          (bool) {
                                                            setState(() {
                                                              users2.stkBookV =
                                                                  !users2
                                                                      .stkBookV!;
                                                            });
                                                            apicallstoupdatepermission(
                                                                "StkBook_V",
                                                                users2
                                                                    .stkBookV!);
                                                          },
                                                          //pbook i
                                                          users2.stkBookI!,
                                                          (bool) {
                                                            setState(() {
                                                              users2.stkBookI =
                                                                  !users2
                                                                      .stkBookI!;
                                                            });
                                                            apicallstoupdatepermission(
                                                                "StkBook_I",
                                                                users2
                                                                    .stkBookI!);
                                                          },
                                                          //pbook e
                                                          users2.stkBookE!,
                                                          (bool) {
                                                            setState(() {
                                                              users2.stkBookE =
                                                                  !users2
                                                                      .stkBookE!;
                                                            });
                                                            apicallstoupdatepermission(
                                                                "StkBook_E",
                                                                users2
                                                                    .stkBookE!);
                                                          },
                                                          //pbook d
                                                          users2.stkBookD!,
                                                          (bool) {
                                                            setState(() {
                                                              users2.stkBookD =
                                                                  !users2
                                                                      .stkBookD!;
                                                            });
                                                            apicallstoupdatepermission(
                                                                "StkBook_D",
                                                                users2.sBookD!);
                                                          }),
                                                    ],
                                                  )),
                                                ],
                                              ),
                                              namewidget(
                                                  "Financial Statements"),
                                              listtilewidgetsingle(
                                                  "Trial Balance",
                                                  users2.trialBalance!,
                                                  (v) {}),
                                              listtilewidgetsingle(
                                                  "Income Statement",
                                                  users2.incomeStatement!,
                                                  (v) {})
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                ),
              ))),
        ],
      ),
    );
  }

  checkboxwidgets(bool bool, void function(bool)) {
    return Checkbox(value: bool, onChanged: function);
  }

  apicallstoupdatepermission(String name, bool boolsv) async {
    await apicall(
        "UPDATE users SET $name = '$boolsv' WHERE UserName = '$username' and Password = '$password'");
  }

  // ignore: avoid_types_as_parameter_names, use_function_type_syntax_for_parameters
  listtilewidget(
      String title,
      bool boolsk1,
      void function1(v),
      // ignore: avoid_types_as_parameter_names, use_function_type_syntax_for_parameters
      bool boolsk2,
      void function2(v),
      // ignore: avoid_types_as_parameter_names, use_function_type_syntax_for_parameters
      bool boolsk3,
      void function3(v),
      // ignore: avoid_types_as_parameter_names, use_function_type_syntax_for_parameters
      bool boolsk4,
      void function4(v)) {
    return ListTile(
      dense: true,
      title: Row(
        children: [
          checkboxwidgets(boolsk1, function1),
          checkboxwidgets(boolsk2, function2),
          checkboxwidgets(boolsk3, function3),
          checkboxwidgets(boolsk4, function4),
        ],
      ),
      subtitle: Text(title),
    );
  }

  listtilewidgetsingle(
    String title,
    bool boolsk1,
    void function1(v),
  ) {
    return ListTile(
      dense: true,
      title: Row(
        children: [
          checkboxwidgets(boolsk1, function1),
        ],
      ),
      subtitle: Text(title),
    );
  }

  String username = "";
  String password = "";
}

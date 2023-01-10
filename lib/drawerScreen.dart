// ignore: file_names
import 'package:bm/Screens/authentication/admin_model.dart';
import 'package:bm/Screens/dailybooks/journalVouchers/main.dart';
import 'package:bm/Screens/dailybooks/payments/payments_main.dart';
import 'package:bm/Screens/dailybooks/receipts/mainpage.dart';
import 'package:bm/Screens/dailybooks/transfers/main.dart';
import 'package:bm/Screens/special_books/account_manager/account_manager_main.dart';
import 'package:bm/Screens/special_books/assets_ledger/assets_ledger.dart';

import 'package:bm/Screens/special_books/capital_ledger/capital_ledger.dart';
import 'package:bm/Screens/special_books/charts_of_account/charts_of_account.dart';
import 'package:bm/Screens/special_books/expense_ledger/expense_ledger.dart';
import 'package:bm/Screens/special_books/liavilities_ledger/liablities_ledger.dart';
import 'package:bm/Screens/special_books/revenue_ledger/revenue_ledger.dart';
import 'package:bm/Screens/special_books/stock_ledger.dart/stock_ledger.dart';
import 'package:bm/Screens/special_books/stock_manager/stock_main.dart';
import 'package:bm/Screens/utilities/users.dart';
import 'package:bm/responsive.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatefulWidget {
  final List<AdminModel> permissionList;
  const DrawerScreen({super.key, required this.permissionList});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  List<bool> _selected = List.generate(4, (i) => false);
  // ignore: non_constant_identifier_names
  List<bool> _Subselected = List.generate(10, (i) => false);
  List draweroptions = [
    "Daily Books",
    "Special Books",
    "Utilities",
    "statements"
  ];
  List<String> dailybooklist = [
    "Purchase Invoice",
    "Sale Invoice",
    "Transfers",
    "Receipt",
    "Payments",
    "Journal Vouchers"
  ];
  List<String> specialbooklist = [
    "Assets Ledger",
    "Expensive Ledger",
    "liablities Ledger",
    "Revenue Ledger",
    "Capital Ledger",
    "Stock Ledger",
    "Stock Manager",
    "Account Manager",
    "Chart Of Account"
  ];
  List<String> utilitieslist = [
    "Add/Remove User",
  ];
  List<String> finaciallist = [
    "Trial Balance",
    "Income Statement",
    "Balance Sheet",
    "Age Trial Balance"
  ];

  final List<IconData> iconslist = [
    Icons.dashboard,
    Icons.verified,
    Icons.people,
    Icons.report,
  ];

  @override
  void initState() {
    _selected[0] = true;
    _Subselected[0] = true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Responsive.isMobile(context)
          ? SizedBox(
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6, right: 6),
                          child: Scaffold(
                            backgroundColor: const Color(0xfff7f7f7),
                            body: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                const CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSPWhDcrmhvY86Q42jr73c-812hSyMhO3DxTXRt2H6uxgiLKsnktZsZfJ-14AvPaqR01k&usqp=CAU"),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    namewidget(
                                        "ADMIN 123 ${widget.permissionList.length}"),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 20,
                                    left: Responsive.isMobile(context)
                                        ? 0
                                        : Responsive.isTablet(context)
                                            ? 0
                                            : 10,
                                    right: Responsive.isMobile(context)
                                        ? 0
                                        : Responsive.isTablet(context)
                                            ? 0
                                            : 10,
                                  ),
                                  child: SizedBox(
                                    height: 60 *
                                        double.parse(
                                            draweroptions.length.toString()),
                                    child: ListView.builder(
                                      itemCount: draweroptions.length,
                                      itemBuilder: (_, i) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 2, right: 2, top: 5),
                                          child: Container(
                                            color: _selected[i]
                                                ? const Color(0xffffffff)
                                                : null,
                                            child: ListTile(
                                              dense: true,
                                              tileColor: _selected[i]
                                                  ? const Color(0xffffffff)
                                                  : null, // If current item is selected show blue color
                                              title: Row(
                                                children: [
                                                  Responsive.isTablet2(context)
                                                      ? Container()
                                                      : Icon(
                                                          iconslist[i],
                                                          color: _selected[i]
                                                              ? const Color(
                                                                  0xff773cb1)
                                                              : null,
                                                          size: 15,
                                                        ),
                                                  Responsive.isTablet2(context)
                                                      ? Container()
                                                      : const SizedBox(
                                                          width: 10),
                                                  Responsive.isTablet(context)
                                                      ? Container()
                                                      : Text(
                                                          draweroptions[i],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: _selected[
                                                                      i]
                                                                  ? Colors.black
                                                                  : const Color(
                                                                      0xff6d7885),
                                                              fontSize: 12),
                                                        ),
                                                ],
                                              ),
                                              onTap: () => setState(() {
                                                _Subselected = List.filled(
                                                    _Subselected.length, false,
                                                    growable: true);
                                                _selected = List.filled(
                                                    _selected.length, false,
                                                    growable: true);

                                                _Subselected[0] = true;
                                                print(_Subselected[0]);

                                                _selected[i] = !_selected[i];
                                              }), // Reverse bool value
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      top: 20, left: 10, right: 10),
                                  child: Divider(
                                    thickness: 1,
                                    color: Colors.black12,
                                  ),
                                ),
                                Responsive.isMobile(context)
                                    ? Container()
                                    : Responsive.isTablet(context)
                                        ? Container()
                                        : const SizedBox(
                                            height: 100,
                                          ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.logout)),
                              ],
                            ),
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 2,
                      child: Container(
                        color: Colors.green,
                        child: screenss(),
                      )),
                ],
              ),
            )
          : Responsive.isTablet3(context)
              ? Container(
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 6, right: 6),
                              child: Scaffold(
                                backgroundColor: const Color(0xfff7f7f7),
                                body: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSPWhDcrmhvY86Q42jr73c-812hSyMhO3DxTXRt2H6uxgiLKsnktZsZfJ-14AvPaqR01k&usqp=CAU"),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        namewidget("ADMIN 123"),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 20,
                                        left: Responsive.isMobile(context)
                                            ? 0
                                            : Responsive.isTablet(context)
                                                ? 0
                                                : 10,
                                        right: Responsive.isMobile(context)
                                            ? 0
                                            : Responsive.isTablet(context)
                                                ? 0
                                                : 10,
                                      ),
                                      child: SizedBox(
                                        height: 60 *
                                            double.parse(draweroptions.length
                                                .toString()),
                                        child: ListView.builder(
                                          itemCount: draweroptions.length,
                                          itemBuilder: (_, i) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 2, right: 2, top: 5),
                                              child: Container(
                                                color: _selected[i]
                                                    ? const Color(0xffffffff)
                                                    : null,
                                                child: ListTile(
                                                  dense: true,
                                                  tileColor: _selected[i]
                                                      ? const Color(0xffffffff)
                                                      : null, // If current item is selected show blue color
                                                  title: Row(
                                                    children: [
                                                      Responsive.isTablet2(
                                                              context)
                                                          ? Container()
                                                          : Icon(
                                                              iconslist[i],
                                                              color: _selected[
                                                                      i]
                                                                  ? const Color(
                                                                      0xff773cb1)
                                                                  : null,
                                                              size: 15,
                                                            ),
                                                      Responsive.isTablet2(
                                                              context)
                                                          ? Container()
                                                          : const SizedBox(
                                                              width: 10),
                                                      Responsive.isTablet(
                                                              context)
                                                          ? Container()
                                                          : Text(
                                                              draweroptions[i],
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: _selected[
                                                                          i]
                                                                      ? Colors
                                                                          .black
                                                                      : const Color(
                                                                          0xff6d7885),
                                                                  fontSize: 12),
                                                            ),
                                                    ],
                                                  ),
                                                  onTap: () => setState(() {
                                                    _Subselected = List.filled(
                                                        _Subselected.length,
                                                        false,
                                                        growable: true);
                                                    _selected = List.filled(
                                                        _selected.length, false,
                                                        growable: true);

                                                    _selected[i] =
                                                        !_selected[i];
                                                  }), // Reverse bool value
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          top: 20, left: 10, right: 10),
                                      child: Divider(
                                        thickness: 1,
                                        color: Colors.black12,
                                      ),
                                    ),
                                    Responsive.isMobile(context)
                                        ? Container()
                                        : Responsive.isTablet(context)
                                            ? Container()
                                            : const SizedBox(
                                                height: 100,
                                              ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.logout)),
                                  ],
                                ),
                              ),
                            ),
                          )),
                      Expanded(
                          flex: 2,
                          child: Container(
                            color: Colors.green,
                            child: screenss(),
                          )),
                    ],
                  ),
                )
              : null,
      appBar: AppBar(
        actions: Responsive.isMobile(context)
            ? []
            : Responsive.isTablet3(context)
                ? []
                : [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.notifications,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Welcome:  ${widget.permissionList.first.userName}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSPWhDcrmhvY86Q42jr73c-812hSyMhO3DxTXRt2H6uxgiLKsnktZsZfJ-14AvPaqR01k&usqp=CAU"),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                        ],
                      ),
                    )
                  ],
        backgroundColor: const Color(0xfff7f7f7),
        iconTheme: const IconThemeData(color: Colors.black),
        title: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Responsive.isMobile(context)
                  ? Container()
                  : Responsive.isTablet3(context)
                      ? Container()
                      : const SizedBox(
                          child: CircleAvatar(
                            radius: 20,
                            child: Icon(Icons.business_sharp),
                          ),
                        ),
              const SizedBox(
                width: 5,
              ),
              const Text(
                "BUSSINESS MANAGER",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
            child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Responsive.isMobile(context)
                      ? Container()
                      : Responsive.isTablet3(context)
                          ? Container()
                          : Expanded(
                              flex: Responsive.isTablet(context) ? 1 : 2,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 6, right: 6),
                                child: Scaffold(
                                  backgroundColor: const Color(0xfff7f7f7),
                                  body: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: 20,
                                            left: Responsive.isMobile(context)
                                                ? 0
                                                : Responsive.isTablet(context)
                                                    ? 0
                                                    : 10,
                                            right: Responsive.isMobile(context)
                                                ? 0
                                                : Responsive.isTablet(context)
                                                    ? 0
                                                    : 10,
                                          ),
                                          child: SizedBox(
                                            height: 60 *
                                                double.parse(draweroptions
                                                    .length
                                                    .toString()),
                                            child: ListView.builder(
                                              itemCount: draweroptions.length,
                                              itemBuilder: (_, i) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 2,
                                                          right: 2,
                                                          top: 5),
                                                  child: Container(
                                                    color: _selected[i]
                                                        ? const Color(
                                                            0xffffffff)
                                                        : null,
                                                    child: ListTile(
                                                      dense: true,
                                                      tileColor: _selected[i]
                                                          ? const Color(
                                                              0xffffffff)
                                                          : null, // If current item is selected show blue color
                                                      title: Row(
                                                        children: [
                                                          Responsive.isTablet2(
                                                                  context)
                                                              ? Container()
                                                              : Icon(
                                                                  iconslist[i],
                                                                  color: _selected[
                                                                          i]
                                                                      ? const Color(
                                                                          0xff773cb1)
                                                                      : null,
                                                                  size: 20,
                                                                ),
                                                          Responsive.isTablet2(
                                                                  context)
                                                              ? Container()
                                                              : const SizedBox(
                                                                  width: 10),
                                                          Responsive.isTablet(
                                                                  context)
                                                              ? Container()
                                                              : Text(
                                                                  draweroptions[
                                                                      i],
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: _selected[
                                                                              i]
                                                                          ? Colors
                                                                              .black
                                                                          : const Color(
                                                                              0xff6d7885),
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                        ],
                                                      ),
                                                      onTap: () => setState(() {
                                                        _Subselected =
                                                            List.filled(
                                                                _Subselected
                                                                    .length,
                                                                false,
                                                                growable: true);
                                                        _selected = List.filled(
                                                            _selected.length,
                                                            false,
                                                            growable: true);

                                                        _Subselected.first =
                                                            true;

                                                        _selected[i] =
                                                            !_selected[i];
                                                      }), // Reverse bool value
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              top: 20, left: 10, right: 10),
                                          child: Divider(
                                            thickness: 1,
                                            color: Colors.black12,
                                          ),
                                        ),
                                        Responsive.isMobile(context)
                                            ? Container()
                                            : Responsive.isTablet(context)
                                                ? Container()
                                                : const SizedBox(
                                                    height: 100,
                                                  ),
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.logout)),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                  Responsive.isMobile(context)
                      ? Container()
                      : Responsive.isTablet3(context)
                          ? Container()
                          : _selected[2] == true && _Subselected[0] == true
                              ? Container()
                              : Expanded(flex: 2, child: screenss()),
                  Expanded(flex: 8, child: callSubScreens()),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }

  screensChild(int length, List<String> list) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: SizedBox(
                height: 75 * double.parse(length.toString()),
                child: ListView.builder(
                  itemCount: length,
                  itemBuilder: (_, i) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 2, right: 2, top: 5),
                      child: Container(
                        color: _Subselected[i] ? const Color(0xffffffff) : null,
                        child: ListTile(
                          tileColor: _Subselected[i]
                              ? const Color(0xffffffff)
                              : null, // If current item is selected show blue color
                          title: Row(
                            children: [
                              Responsive.isTablet2(context)
                                  ? Container()
                                  : Responsive.isTablet(context)
                                      ? Container()
                                      : Responsive.isTablet3(context)
                                          ? Container()
                                          : Icon(
                                              Icons.ac_unit,
                                              color: _Subselected[i]
                                                  ? const Color(0xff773cb1)
                                                  : null,
                                            ),
                              const SizedBox(width: 5),
                              Text(
                                list[i],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                    color: _Subselected[i]
                                        ? Colors.black
                                        : const Color(0xff6d7885),
                                    fontSize: 12),
                              ),
                            ],
                          ),
                          onTap: () => setState(() {
                            _Subselected = List.filled(
                                _Subselected.length, false,
                                growable: true);
                            _Subselected[i] = !_Subselected[i];
                            Responsive.isMobile(context)
                                ? Navigator.pop(context)
                                : Responsive.isTablet3(context)
                                    ? Navigator.pop(context)
                                    : null;
                          }), // Reverse bool value
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  screenss() {
    if (_selected[0] == true) {
      return screensChild(dailybooklist.length, dailybooklist);
    } else if (_selected[1] == true) {
      return screensChild(specialbooklist.length, specialbooklist);
    } else if (_selected[2] == true) {
      return screensChild(utilitieslist.length, utilitieslist);
    } else if (_selected[3] == true) {
      return screensChild(finaciallist.length, finaciallist);
    }
  }

  callSubScreens() {
    final lists = _Subselected.where((element) => element == true).toList();

    //daily books
    if (_selected[0] == true) {
      if (lists.isEmpty) {
        return containerwidget("Select from Daily Books");
      }
      if (_Subselected[0] == true) {
        return Container(
          color: Colors.amber,
        );
      } else if (_Subselected[1] == true) {
        return Container(
          color: Colors.green,
        );
      } else if (_Subselected[2] == true) {
        if (widget.permissionList.first.tBookV == false) {
          return containerwidget("youre restricted from this page");
        } else {
          return const TransferMainpage();
        }
      } else if (_Subselected[3] == true) {
        return const ReceiptPageMain();
      } else if (_Subselected[4] == true) {
        return const PaymentsPageMain();
      } else if (_Subselected[5] == true) {
        return const JournalVouchers();
      }
    }
    // special book

    else if (_selected[1] == true) {
      if (lists.isEmpty) {
        return containerwidget("Select from Special Books");
      }
      if (_Subselected[0] == true) {
        return const AssetsLedger();
      } else if (_Subselected[1] == true) {
        return const ExpenseLedger();
      } else if (_Subselected[2] == true) {
        return const LiabilityLedger();
      } else if (_Subselected[3] == true) {
        return const RevenueLedger();
      } else if (_Subselected[4] == true) {
        return const Capitalledger();
      } else if (_Subselected[5] == true) {
        return const stock_ledger();
      } else if (_Subselected[6] == true) {
        return const StockMainPage();
      } else if (_Subselected[7] == true) {
        return const AccountManagerMain();
      } else if (_Subselected[8] == true) {
        return const ChartsOfAccountMain();
      }
    }
    //
    // utilities
    //
    //

    else if (_selected[2] == true) {
      if (lists.isEmpty) {
        return containerwidget("Select from Utilities");
      }
      if (_Subselected[0] == true) {
        return const UsersdataPage();
      }
    }

    //
    // statements
    //
    //
    else if (_selected[3] == true) {
      if (lists.isEmpty) {
        return containerwidget("Select from  Statement");
      }
      if (_Subselected[0] == true) {
        return Container(
          color: Colors.lightGreen,
        );
      } else if (_Subselected[1] == true) {
        return Container(
          color: Colors.purpleAccent,
        );
      } else if (_Subselected[2] == true) {
        return Container(
          color: Colors.pink,
        );
      } else if (_Subselected[3] == true) {
        return Container(
          color: Colors.yellowAccent,
        );
      }
    }
  }

  containerwidget(String text) {
    return SizedBox(
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

import 'package:bm/Screens/special_books/account_manager/account_manager_main.dart';
import 'package:bm/Screens/special_books/ledger_pdf.dart';
import 'package:bm/Screens/special_books/ledgers_data/ledgers.dart';
import 'package:bm/Screens/special_books/ledgers_data/service.dart';
import 'package:bm/responsive.dart';
import 'package:flutter/material.dart';

ledgerwidget(
    bool bool,
    Widget widget,
    BuildContext context,
    List<LedgersModel> searchfilters,
    double width,
    Widget tablewidget,
    Widget textfield,
    String name) {
  final LedgerService service = LedgerService();
  return Card(
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
                      child: Row(
                    children: [
                      widget,
                      Responsive.isMobile(context)
                          ? Container()
                          : Responsive.isTablet(context)
                              ? Container()
                              : namewidget("Non Zeroed Accounts")
                    ],
                  )),
                  SizedBox(
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LedgerPdfPreviewPage(
                              invoice: searchfilters,
                              textname: name,
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
                  Expanded(child: textfield)
                ],
              ),
            )),
            Responsive.isMobile(context)
                ? Expanded(
                    child: searchfilters.isEmpty
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 75 *
                                      double.parse(
                                          searchfilters.length.toString()),
                                  child: ListView.builder(
                                      itemCount: searchfilters.length,
                                      itemBuilder: ((context, index) {
                                        LedgersModel users =
                                            searchfilters[index];

                                        return Card(
                                          elevation: 10,
                                          child: ListTile(
                                            trailing:
                                                Text(users.balance.toString()),
                                            title: Row(
                                              children: [
                                                Text(users.acCode ?? ""),
                                                const Text("  -  "),
                                                Text(users.acName ?? ""),
                                              ],
                                            ),
                                            subtitle: Text(users.telephone
                                                        .toString()
                                                        .trim() ==
                                                    "null"
                                                ? "-"
                                                : users.telephone.toString()),
                                          ),
                                        );
                                      })),
                                )
                              ],
                            ),
                          ))
                : Expanded(
                    child: FutureBuilder(
                      future: Future.wait([service.getstockdata()]),
                      builder: (
                        BuildContext context,
                        AsyncSnapshot snapshot,
                      ) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          if (snapshot.hasError) {
                            return const Text('Error');
                          } else if (snapshot.hasData) {
                            return searchfilters.isEmpty
                                ? const Center(
                                    child: Text(
                                      "No Data",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                            width: width, child: tablewidget)
                                      ],
                                    ),
                                  );
                          } else {
                            return const Text('Empty data');
                          }
                        } else {
                          return Text('State: ${snapshot.connectionState}');
                        }
                      },
                    ),
                  ),
            Container(
              height: 40,
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.only(left: 0, right: 0),
                child: Row(
                  mainAxisAlignment: Responsive.isMobile(context)
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          const Text(
                            "Total:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            searchfilters
                                .fold(
                                    0,
                                    (previousValue, element) =>
                                        previousValue + element.balance!)
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
  );
}

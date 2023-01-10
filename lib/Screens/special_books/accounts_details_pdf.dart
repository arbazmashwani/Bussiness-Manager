import 'dart:typed_data';

import 'package:bm/Screens/special_books/account_manager/account_manager_model.dart';

import 'package:flutter/material.dart';

import 'package:pdf/widgets.dart' as pw;

import 'package:printing/printing.dart';

class AccountsdetailsPdf extends StatelessWidget {
  final List<details_model> invoice;
  const AccountsdetailsPdf({Key? key, required this.invoice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => makePdf(invoice),
      ),
    );
  }
}

Future<Uint8List> makePdf(List<details_model> invoice) async {
  final pdf = pw.Document();
  pdf.addPage(
    pw.MultiPage(
      maxPages: 100,
      build: (context) => [
        pw.Divider(thickness: 1),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 20, right: 20, top: 20),
          child: pw.Text("BM",
              style:
                  pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 22)),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: pw.Text("Accounts Detailed Information",
              style:
                  pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 22)),
        ),
        pw.Table.fromTextArray(context: context, data: <List<dynamic>>[
          <String>['A/c Name', 'City', 'PH No', 'Fax No', 'Contact Person'],
          ...invoice
              .map((user) => [
                    user.name,
                    user.city.toString().trim() == "null" ? "" : user.city,
                    user.telephone.toString().trim() == "null"
                        ? ""
                        : user.telephone,
                    user.fax.toString().trim() == "null" ? "" : user.fax,
                    user.contact.toString().trim() == "null"
                        ? ""
                        : user.contact,
                  ])
              .toList()
        ]),
      ],
    ),
  );
  return pdf.save();
}

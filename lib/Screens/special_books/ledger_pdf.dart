import 'dart:typed_data';

import 'package:bm/Screens/special_books/ledgers_data/ledgers.dart';
import 'package:bm/Screens/special_books/stock_manager/stock_model.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:printing/printing.dart';

class LedgerPdfPreviewPage extends StatelessWidget {
  final List<LedgersModel> invoice;
  final String textname;
  const LedgerPdfPreviewPage(
      {Key? key, required this.invoice, required this.textname})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => makePdf(invoice, textname),
      ),
    );
  }
}

Future<Uint8List> makePdf(List<LedgersModel> invoice, String name) async {
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
          child: pw.Text(name,
              style:
                  pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 22)),
        ),
        pw.Table.fromTextArray(context: context, data: <List<dynamic>>[
          <String>[
            'A/c Code',
            'A/c Name',
            'Debit Amount',
            'Credit Amount',
            'Telephone'
          ],
          ...invoice
              .map((user) => [
                    user.acCode,
                    user.acName,
                    int.parse(user.balance.toString()) > 0 ? user.balance : "0",
                    int.parse(user.balance.toString()) < 0 ? user.balance : "0",
                    user.telephone.toString().trim() == "null"
                        ? ''
                        : user.telephone,
                  ])
              .toList()
        ]),
        pw.Padding(
            padding: const pw.EdgeInsets.all(8),
            child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Row(children: [
                    pw.Text("Total :",
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize: 15)),
                    pw.SizedBox(width: 8),
                    pw.Text(invoice.length.toString(),
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize: 15)),
                  ]),
                  pw.Padding(
                      padding: const pw.EdgeInsets.only(right: 100),
                      child: pw.Row(children: [
                        pw.Text(
                            invoice.fold(
                                        0,
                                        (previousValue, element) =>
                                            previousValue + element.balance!) >
                                    0
                                ? invoice
                                    .fold(
                                        0,
                                        (previousValue, element) =>
                                            previousValue + element.balance!)
                                    .toString()
                                : "0",
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold, fontSize: 12)),
                        pw.SizedBox(width: 100),
                        pw.Text(
                            invoice.fold(
                                        0,
                                        (previousValue, element) =>
                                            previousValue + element.balance!) <
                                    0
                                ? invoice
                                    .fold(
                                        0,
                                        (previousValue, element) =>
                                            previousValue + element.balance!)
                                    .toString()
                                : "0",
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold, fontSize: 12)),
                      ]))
                ])),
        pw.Divider(thickness: 1),
      ],
    ),
  );
  return pdf.save();
}

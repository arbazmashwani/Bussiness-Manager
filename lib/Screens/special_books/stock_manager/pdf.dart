import 'dart:typed_data';

import 'package:bm/Screens/special_books/stock_manager/stock_model.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:printing/printing.dart';

class PdfPreviewPage extends StatelessWidget {
  final List<StockManagerModel> invoice;
  const PdfPreviewPage({Key? key, required this.invoice}) : super(key: key);

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

Future<Uint8List> makePdf(List<StockManagerModel> invoice) async {
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
          child: pw.Text("Opening Stock Summary",
              style:
                  pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 22)),
        ),
        pw.Table.fromTextArray(context: context, data: <List<dynamic>>[
          <String>['Code', 'Description', 'INick', 'B/F QTY', 'Cost', 'Amount'],
          ...invoice
              .map((user) => [
                    user.iCode,
                    user.iDescription,
                    user.iNick,
                    user.opQty.toString(),
                    user.priceList,
                    user.stockIn
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
                  pw.Text(
                      invoice
                          .fold(
                              0,
                              (previousValue, element) =>
                                  previousValue + element.stockIn!)
                          .toString(),
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 15)),
                ])),
        pw.Divider(thickness: 1),
      ],
    ),
  );
  return pdf.save();
}

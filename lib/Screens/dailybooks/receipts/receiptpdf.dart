import 'dart:typed_data';

import 'package:bm/Screens/dailybooks/receipts/models.dart';

import 'package:flutter/material.dart';

import 'package:pdf/widgets.dart' as pw;

import 'package:printing/printing.dart';

class ReceiptPdfMain extends StatelessWidget {
  final List<ReceiptModel> invoice;
  final String textjournal;
  ReceiptPdfMain({Key? key, required this.invoice, required this.textjournal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => makePdf(
          invoice,
          textjournal,
        ),
      ),
    );
  }
}

Future<Uint8List> makePdf(
    List<ReceiptModel> invoice, String textjournal) async {
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
          child: pw.Text("${textjournal} Journal",
              style:
                  pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 22)),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: pw.Text("from 2007/01/01 To ${invoice.last.dated.toString()}",
              style:
                  pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 22)),
        ),
        pw.Table.fromTextArray(context: context, data: <List<dynamic>>[
          <String>[
            'Date',
            'ReceiptsFrom (AC CR)',
            'Particulars',
            'ReceiptsAs (AC DR)',
            'Amount'
          ],
          ...invoice
              .map((user) => [
                    user.dated,
                    user.recieptFrom,
                    user.particulars,
                    user.receiptAs,
                    user.amount.toString(),
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
                                  previousValue + element.amount!)
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

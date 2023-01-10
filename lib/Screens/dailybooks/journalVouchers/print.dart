import 'dart:typed_data';

import 'package:bm/Screens/dailybooks/journalVouchers/model.dart';
import 'package:flutter/material.dart';

import 'package:pdf/widgets.dart' as pw;

import 'package:printing/printing.dart';

class printjournalvouchers extends StatelessWidget {
  final List<jouranl_voucher_d_model> invoice;
  final String textname;
  final String remarks;
  final String voucherno;
  final String dated;
  const printjournalvouchers({
    Key? key,
    required this.invoice,
    required this.textname,
    required this.remarks,
    required this.voucherno,
    required this.dated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) =>
            makePdf(invoice, textname, remarks, voucherno, dated),
      ),
    );
  }
}

Future<Uint8List> makePdf(List<jouranl_voucher_d_model> invoice, String name,
    String remarks, String voucherno, String dated) async {
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
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
          pw.Padding(
            padding: const pw.EdgeInsets.only(left: 20, right: 0, bottom: 5),
            child: pw.Text(
                "Voucher No : ${voucherno.toString().trim() == "" ? "-" : voucherno}",
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12)),
          ),
        ]),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
          pw.Padding(
            padding: const pw.EdgeInsets.only(left: 20, right: 0, bottom: 5),
            child: pw.Text(
                "Dated : ${dated.toString().trim() == "" ? "-" : dated}",
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12)),
          ),
        ]),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: pw.Text(
              "Remarks : ${remarks.toString().trim() == "" ? "-" : remarks}",
              style:
                  pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12)),
        ),
        pw.Table.fromTextArray(context: context, data: <List<dynamic>>[
          <String>[
            'Description',
            'Particulars',
            'Debit',
            'Credit',
          ],
          ...invoice
              .map((user) => [
                    user.acCode,
                    user.particulars,
                    user.debit ?? "0",
                    user.credit ?? "0",
                  ])
              .toList()
        ]),
        pw.SizedBox(width: 30),
        pw.Divider(thickness: 1),
        pw.Padding(
            padding: const pw.EdgeInsets.all(8),
            child:
                pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
              pw.Padding(
                  padding: const pw.EdgeInsets.only(right: 0),
                  child: pw.Row(children: [
                    pw.Text(
                        invoice
                            .fold(
                                0,
                                (previousValue, element) =>
                                    previousValue + element.debit!)
                            .toString(),
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize: 12)),
                    pw.SizedBox(width: 60),
                    pw.Text(
                        invoice
                            .fold(
                                0,
                                (previousValue, element) =>
                                    previousValue + element.credit!)
                            .toString(),
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize: 12)),
                  ]))
            ])),
        pw.Divider(thickness: 1),
        pw.SizedBox(width: 10),
        pw.Divider(thickness: 1),
      ],
    ),
  );
  return pdf.save();
}

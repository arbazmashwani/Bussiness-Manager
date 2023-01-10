import 'dart:typed_data';

import 'package:bm/Screens/dailybooks/receipts/models.dart';
import 'package:bm/Screens/special_books/account_manager/account_manager_main.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:pdf/widgets.dart' as pw;

import 'package:printing/printing.dart';

class Userbalancepdf extends StatelessWidget {
  final String textjournal;
  final String receivefrom;
  final String receiveas;
  final String amount;
  final String particulars;
  final String currentbalance;

  Userbalancepdf(
      {Key? key,
      required this.textjournal,
      required this.amount,
      required this.receiveas,
      required this.receivefrom,
      required this.particulars,
      required this.currentbalance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => makePdf(textjournal, receiveas, receivefrom, amount,
            particulars, currentbalance),
      ),
    );
  }
}

Future<Uint8List> makePdf(
    String textjournal,
    String receiveas,
    String receivefrom,
    String amount,
    String particulars,
    String currentbalance) async {
  num Nums = (num.parse(amount.toString())) + num.parse(currentbalance);
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
          child: pw.Text(
              "DATED: ${DateFormat("yyy/MM/dd").format(DateTime.now())}",
              style:
                  pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 22)),
        ),
        pw.Row(children: [
          pw.Expanded(
              child: pw.Column(children: [
            pw.Text(
              "Received From: (CR)",
            ),
            pw.Text(
              "Received AS: (DR)",
            ),
            pw.Text(
              "Particulars:",
            ),
            pw.Text(
              "Amount:",
            ),
          ])),
          pw.Expanded(
              flex: 2,
              child: pw.Column(children: [
                pw.Text(receivefrom,
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      decoration: pw.TextDecoration.underline,
                    )),
                pw.Text(receiveas,
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      decoration: pw.TextDecoration.underline,
                    )),
                pw.Text(particulars,
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                    )),
                pw.Text(amount,
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                    )),
              ]))
        ]),
        pw.SizedBox(height: 60),

        //
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
          pw.Column(children: [
            pw.Row(children: [
              pw.Text(
                "Prev. Balance:",
              ),
              pw.SizedBox(width: 10),
              pw.Text(Nums.toString(),
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                  )),
            ]),
            pw.Row(children: [
              pw.Text(
                "Amount:",
              ),
              pw.SizedBox(width: 10),
              pw.Text("-${amount}",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                  )),
            ]),
          ]),
        ]),

        pw.Divider(
          thickness: 1,
        ),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
          pw.Text(
            "Current Balance:",
          ),
          pw.SizedBox(width: 10),
          pw.Text(currentbalance,
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
              )),
        ]),
      ],
    ),
  );
  return pdf.save();
}

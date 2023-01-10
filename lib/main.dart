import 'dart:convert';

import 'package:bm/Screens/authentication/login.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login(),
    );
  }
}

apicall(String query) async {
  final uri = Uri.parse('http://192.168.0.92:80/api/SSMS/FETCH');
  final headers = {
    'Content-Type': 'application/json',
  };
  String body = query;
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');

  var response = await http.post(uri,
      headers: headers, body: jsonBody, encoding: encoding);

  return response;
}

void displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
  /*msg: '',
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM ,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0*/
}

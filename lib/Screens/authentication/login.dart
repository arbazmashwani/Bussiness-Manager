import 'package:bm/Screens/authentication/admin_model.dart';
import 'package:bm/Screens/special_books/account_manager/account_manager_main.dart';
import 'package:bm/drawerScreen.dart';
import 'package:bm/main.dart';
import 'package:bm/widgets.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:convert' as convert;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white54,
      child: Center(
        child: Card(
          elevation: 10,
          child: Container(
            height: 500,
            width: 500,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRms4SSvT_4IGE0kKkrS1oMdBLjREB9wJCNQA&usqp=CAU"),
                ),
                namewidget("Email"),
                const SizedBox(
                  width: 5,
                ),
                textfieldwidget3(
                    emailcontroller, "Email", (val) {}, 1, 1, 10, false, false),
                Text(
                  emailerror.isEmpty ? "" : emailerror,
                  style: const TextStyle(color: Colors.red),
                ),
                namewidget("Password"),
                const SizedBox(
                  width: 5,
                ),
                textfieldwidget3(passwordcontroller, "Password", (val) {}, 1, 1,
                    10, false, showpassword),
                Text(
                  passworderror.isEmpty ? "" : passworderror,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(
                  width: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Checkbox(value: true, onChanged: (val) {}),
                      namewidget("save password?")
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(15)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side:
                                        const BorderSide(color: Colors.blue)))),
                        onPressed: () async {
                          //  check network availibility
                          var conectivityResult =
                              await Connectivity().checkConnectivity();
                          if (conectivityResult !=
                                  ConnectivityResult.ethernet &&
                              conectivityResult != ConnectivityResult.wifi) {
                            displayToastMessage(
                                'No Internet Connectivity.', context);
                            return;
                          } else {
                            setState(() {
                              emailerror = "";
                              passworderror = "";
                            });
                            final response = await apicall(
                                "select * from users where UserName = '${emailcontroller.text}'");
                            if (response.body.toString() == "[]") {
                              setState(() {
                                emailerror = "Invalid Email";
                              });
                            } else {
                              var data = [];
                              data = convert.jsonDecode(response.body);
                              List<AdminModel> dataresult = [];
                              List<AdminModel> checkpassword = [];
                              dataresult = data
                                  .map((e) => AdminModel.fromJson(e))
                                  .toList();

                              checkpassword = dataresult
                                  .where((element) =>
                                      element.password.toString().trim() ==
                                      passwordcontroller.text)
                                  .toList();

                              if (checkpassword.isEmpty) {
                                setState(() {
                                  passworderror = "Invalid Password";
                                });
                              } else {
                                // ignore: use_build_context_synchronously
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DrawerScreen()),
                                  (Route<dynamic> route) => false,
                                );
                              }
                            }
                          }
                        },
                        child: Text("Login".toUpperCase(),
                            style: const TextStyle(fontSize: 22))),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String emailerror = "";
  String passworderror = "";
  bool showpassword = true;
}

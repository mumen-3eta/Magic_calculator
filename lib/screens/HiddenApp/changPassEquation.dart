import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class changPassEquation extends StatefulWidget {
  @override
  State<changPassEquation> createState() => _changPassEquationState();
}

class _changPassEquationState extends State<changPassEquation> {
  TextEditingController operand1_controller = TextEditingController();

  TextEditingController operand2_controller = TextEditingController();

  TextEditingController operand3_controller = TextEditingController();

  TextEditingController operand4_controller = TextEditingController();

  TextEditingController operand5_controller = TextEditingController();

  TextEditingController operand6_controller = TextEditingController();

  Color color = Colors.black;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    Snackbar() {
      return SnackBar(
        content: Text("passEquation Changed".tr()),
        duration: Duration(milliseconds: 2500),
        backgroundColor: Color(0xff0BB300),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff951BDB),
        title: Text("change password".tr()),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.done,
          size: 35,
        ),
        backgroundColor: Color(0xff0BB300),
        onPressed: () async {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          List<String> oldEquation = [
            operand1_controller.text,
            operand2_controller.text,
            operand3_controller.text
          ];
          if (oldEquation.toString() ==
              sharedPreferences.getStringList('passEquation').toString()) {
            if (operand4_controller.text.isNotEmpty &&
                operand5_controller.text.isNotEmpty &&
                operand6_controller.text.isNotEmpty) {
              List<String> NewEquation = [
                operand4_controller.text,
                operand5_controller.text,
                operand6_controller.text
              ];
              sharedPreferences.setStringList('passEquation', NewEquation);
              ScaffoldMessenger.of(context).showSnackBar(Snackbar());
              Navigator.of(context).pop();
            }
            color = Colors.black;
            print("equals");
            setState(() {});
          } else {
            color = Colors.red;
            FocusManager.instance.primaryFocus?.unfocus();

            setState(() {});
            print("not equals");
          }
        },
      ),
      body: Container(
          width: screenWidth,
          margin: EdgeInsets.all(20),
          child: ListView(children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Enter Old PassEquation".tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            width: screenWidth / 5,
                            child: TextField(
                              keyboardType: TextInputType.phone,
                              style: TextStyle(color: color),
                              controller: operand1_controller,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              "First Number".tr(),
                              style: TextStyle(fontSize: 10, color: color),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            width: screenWidth / 5,
                            child: TextField(
                              keyboardType: TextInputType.phone,
                              style: TextStyle(color: color),
                              controller: operand2_controller,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              "Sign".tr(),
                              style: TextStyle(fontSize: 10, color: color),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            width: screenWidth / 5,
                            child: TextField(
                              keyboardType: TextInputType.phone,
                              style: TextStyle(color: color),
                              controller: operand3_controller,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              "Second Number".tr(),
                              style: TextStyle(fontSize: 10, color: color),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Enter New PassEquation".tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            width: screenWidth / 5,
                            child: TextField(
                              keyboardType: TextInputType.phone,
                              controller: operand4_controller,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              "First Number".tr(),
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            width: screenWidth / 5,
                            child: TextField(
                              keyboardType: TextInputType.phone,
                              controller: operand5_controller,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              "Sign".tr(),
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            width: screenWidth / 5,
                            child: TextField(
                              keyboardType: TextInputType.phone,
                              controller: operand6_controller,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              "Second Number".tr(),
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ])),
    );
  }
}

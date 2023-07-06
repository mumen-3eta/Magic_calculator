import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:magic_calculator/screens/HiddenApp/Settings.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/HiddenApp/home.dart';

enum Operator { sum, sub, div, mult, equal }

class Calculator extends StatefulWidget {
  String First_index = "";
  String Second_index = "";

  Operator? operator;

  List<dynamic> operation = ["0"];

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Localizations.override(
      context: this.context,
      locale: Locale('en'),
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(8),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 45),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.grey,
                      ),
                      const BoxShadow(
                        color: Colors.white,
                        spreadRadius: -1.0,
                        blurRadius: 3.0,
                      ),
                    ],
                  ),
                  child: Screen(widget.operation),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(3),
                              height: 10.h,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(0xff945EDB))),
                                onPressed: () {
                                  Clear();
                                },
                                child: ListTile(
                                  // minLeadingWidth: 1,
                                  leading: Icon(
                                    Icons.clear_all,
                                    color: Colors.white,
                                    size: 45,
                                  ),
                                  title: Text(
                                    "clear".tr(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                nomberButton(1),
                                nomberButton(2),
                                nomberButton(3),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                nomberButton(4),
                                nomberButton(5),
                                nomberButton(6),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                nomberButton(7),
                                nomberButton(8),
                                nomberButton(9),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                nomberButton(0),
                                nomberButton('.'),
                                equalButton(),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            backSpaceButton(),
                            operatorButton(Operator.sum),
                            operatorButton(Operator.sub),
                            operatorButton(Operator.mult, Xo: 'x'),
                            operatorButton(Operator.div, Xo: '÷'),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget Screen(List<dynamic> operation) {
    String first_operand = '0';
    String operator = '';
    String second_operand = '';
    if (operation.length == 0) {
      first_operand = '0';
    } else if (operation.length == 1) {
      first_operand = '${operation[0]}';
    } else if (operation.length == 2) {
      first_operand = '${operation[0]}';
      operator = '${operation[1]}';
    } else if (operation.length == 3) {
      first_operand = '${operation[0]}';
      operator = '${operation[1]}';
      second_operand = '${operation[2]}';
    }

    return Text(
        "${first_operand == '' ? '0' : first_operand} $operator $second_operand");
  }

  Widget backSpaceButton() {
    return Container(
      margin: EdgeInsets.all(3),
      height: 10.h,
      width: 22.w,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xff945EDB))),
        onPressed: () {
          if (widget.operation.length == 1 || widget.operation.isEmpty) {
            widget.First_index =
                '${widget.First_index.substring(0, widget.First_index.length > 0 ? widget.First_index.length - 1 : 0)}';
            widget.operation[0] = (widget.First_index);
          } else if (widget.operation.length == 2) {
            widget.operation.removeLast();
          } else if (widget.operation.length == 3) {
            widget.Second_index =
                '${widget.Second_index.substring(0, widget.Second_index.length > 0 ? widget.Second_index.length - 1 : 0)}';
            widget.operation[2] = (widget.Second_index);
            if (widget.Second_index == '') {
              widget.operation.removeLast();
            }
          }
          setState(() {});
        },
        child: Container(
          child: Icon(Icons.backspace),
        ),
      ),
    );
  }

  Widget nomberButton(dynamic nomber) {
    return Container(
      margin: EdgeInsets.all(3),
      height: 13.h,
      width: 22.w,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xff0EC0F7))),
        onPressed: () {
          onNomberClicked(nomber);
          setState(() {});
        },
        child: Container(
          child: Text(
            "$nomber",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget operatorButton(Operator operator, {String? Xo}) {
    return Container(
      margin: EdgeInsets.all(3),
      height: 13.h,
      width: 22.w,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xff945EDB))),
        onPressed: () {
          onOperatorClicked(operator);
          setState(() {});
        },
        child: Container(
          child: Text(
            Xo ?? operatorIcon(operator),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Clear() {
    widget.operation.clear();
    widget.First_index = '';
    widget.Second_index = '';
    widget.operation.add("");
    setState(() {});
  }

  onNomberClicked(dynamic input) {
    if (widget.operation.isEmpty) {
      widget.First_index += '$input';
      widget.operation.add(widget.First_index);
    } else if (widget.operation.length == 1) {
      widget.First_index += '$input';
      widget.operation[0] = (widget.First_index);
    } else if (widget.operation.length == 2) {
      widget.Second_index += '$input';
      widget.operation.add(widget.Second_index);
    } else if (widget.operation.length == 3) {
      widget.Second_index += '$input';
      widget.operation[2] = (widget.Second_index);
    }
  }

  onOperatorClicked(Operator input) {
    if (widget.operation.isEmpty || widget.operation.first == "") {
    } else if (widget.operation.length == 1) {
      widget.operator = input;
      widget.operation.add(operatorIcon(input));
    } else {}
  }

  String operatorIcon(Operator operator) {
    return operator == Operator.div
        ? ('/')
        : operator == Operator.mult
            ? ('*')
            : operator == Operator.sub
                ? ('-')
                : operator == Operator.sum
                    ? ('+')
                    : operator == Operator.equal
                        ? ('=')
                        : ("");
  }

  Widget equalButton() {
    return Container(
      margin: EdgeInsets.all(3),
      height: 13.h,
      width: 22.w,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xff0BB300))),
        onPressed: () {
          onequalClicked(widget.operation);
          setState(() {});
        },
        child: Container(
          child: Text(
            operatorIcon(Operator.equal),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  onequalClicked(List<dynamic> operation) async {
    var pref = await SharedPreferences.getInstance();
    String passEquation = pref.getStringList('passEquation').toString();
    print(passEquation);
    if (operation.toString() == passEquation) {
      operation.clear();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Home()));

      print("Done!");
    } else if (operation.toString() == ['000'].toString()) {
      operation.clear();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Settings()));
    } else if (operation.length == 1 || operation.length == 2) {
    } else if (operation.length == 3) {
      if (operation[0] == '.' || operation[2] == '.') {
        widget.operation.clear();
        widget.operation.add("Invalid equation, Value of ' . '");
      } else {
        if (operation[1] == "+") {
          String temp = (sum(operation[0], operation[2]));
          widget.operation.clear();
          widget.operation.add(temp);
        } else if (operation[1] == "-") {
          String temp = (sub(operation[0], operation[2]));
          widget.operation.clear();
          widget.operation.add(temp);
        } else if (operation[1] == "/") {
          String temp = (div(operation[0], operation[2]));
          widget.operation.clear();
          widget.operation.add(temp);
        } else if (operation[1] == "*") {
          String temp = (mult(operation[0], operation[2]));
          widget.operation.clear();
          widget.operation.add(temp);
        } else {}
      }
    }
    widget.First_index = '';
    widget.Second_index = '';
  }

  String sum(x, y) {
    return (double.parse(x) + double.parse(y)).toString();
  }

  String sub(x, y) {
    return (double.parse(x) - double.parse(y)).toString();
  }

  String mult(x, y) {
    return (double.parse(x) * double.parse(y)).toString();
  }

  String div(x, y) {
    if (int.parse(y) != 0) {
      return (double.parse(x) / double.parse(y)).toString();
    } else {
      return "Can not divide by Zero";
    }
  }
}

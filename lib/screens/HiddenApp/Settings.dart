import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:magic_calculator/main.dart';

import 'package:magic_calculator/screens/HiddenApp/journals_modul/Journals_UI.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/Calculator.dart';
import 'changPassEquation.dart';

class Settings extends StatelessWidget {
  TextEditingController operand1_controller = TextEditingController();
  TextEditingController operand2_controller = TextEditingController();
  TextEditingController operand3_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff951BDB),
        title: Text('Home'.tr()),
      ),
      body: ListView(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: ((context) {
                return Journals_UI();
              })));
            },
            child: Container(
              width: double.infinity,
              height: screenHeight,
              child: ListView(
                children: [
                  // ListTile(
                  //   minLeadingWidth: 4,
                  //   onTap: () {
                  //     App.changeTheme;
                  //   },
                  //   leading: Switch(
                  //     onChanged: (bool value) {},
                  //     value: false,
                  //   ),
                  //   title: Text("Dark Mood".tr()),
                  // ),

                  ListTile(
                    minLeadingWidth: 4,
                    onTap: () {
                      if (context.locale == Locale('en')) {
                        context.setLocale(Locale('ar'));
                        print(context.locale.toString());
                      } else {
                        context.setLocale(Locale('en'));
                      }
                    },
                    leading: Icon(
                      Icons.language,
                      size: 35,
                    ),
                    title: Text("Language".tr()),
                  ),
                  ListTile(
                    minLeadingWidth: 4,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => changPassEquation()));
                    },
                    leading: Icon(
                      Icons.lock_reset,
                      size: 35,
                    ),
                    title: Text("change password".tr()),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

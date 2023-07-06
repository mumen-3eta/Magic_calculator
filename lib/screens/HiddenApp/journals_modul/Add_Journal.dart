import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:magic_calculator/data/JSON_FILS/Journal_JSON.dart';
import 'package:magic_calculator/data/dataBase/DataBase.dart';
import 'package:magic_calculator/widgets/Journal_item_ui.dart';

import '../../../data/dataClasses/Journals.dart';

class Add_Journal extends StatelessWidget {
  String date = DateFormat.yMMMEd().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    TextEditingController heading = TextEditingController();
    TextEditingController content = TextEditingController();
    double screenHight = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: Text("Journal_".tr()),
        backgroundColor: const Color(0xffFF7276),
      ),
      floatingActionButton: FloatingActionButton.large(
        backgroundColor: const Color(0xff0BB300),
        onPressed: () {
          String headingText = heading.text;
          String contentText = content.text;
          if (headingText == '') {
            if (contentText.length > 15) {
              headingText = '${contentText.substring(0, 14)}...';
            } else if (contentText.isNotEmpty) {
              headingText = 'No Heading';
            }
          }
          if (headingText.isEmpty && contentText.isEmpty) {
            Navigator.of(context).pop();
          } else {
            journals['date'] = DateTime.now();
            Journal journal = Journal(headingText, contentText, DateTime.now());
            magicDataBase().addData(table: Tables.journals, app: journal);
            Navigator.of(context).pop();
          }
        },
        child: Icon(
          Icons.done,
          color: Colors.white,
          size: 50,
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: ListView(shrinkWrap: true, children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
            child: TextField(
              controller: heading,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration.collapsed(
                hintText: "Journal Heading".tr(),
                hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
              ),
            ),
          ),
          Container(
            width: screenHight / 2,
            height: (screenHight - screenHight / 2.7),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
            child: TextField(
              controller: content,
              maxLength: 2000,
              maxLines: null,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration.collapsed(
                hintText: "Journal_Content".tr(),
                hintStyle: TextStyle(color: Colors.grey[600]),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

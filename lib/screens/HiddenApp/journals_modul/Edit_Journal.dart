import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:magic_calculator/data/JSON_FILS/Journal_JSON.dart';
import 'package:magic_calculator/data/dataBase/DataBase.dart';

import '../../../data/dataClasses/Journals.dart';

class Edit_Journal extends StatelessWidget {
  String date = DateFormat.yMMMEd().format(DateTime.now());

  int index;

  Edit_Journal(this.index);

  @override
  Widget build(BuildContext context) {
    TextEditingController heading = TextEditingController();
    TextEditingController content = TextEditingController();
    double screenHight = MediaQuery.of(context).size.height;

    heading.text = JournalList[index].heading ?? '';
    content.text = JournalList[index].content ?? '';

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
            } else {
              headingText = 'No Heading';
            }
          }
          Journal journal = Journal(headingText, contentText, DateTime.now());

          magicDataBase().updateData(
              table: Tables.journals, app: journal, id: JournalList[index].id!);
          getJournalsDataFromDB();

          Navigator.of(context).pop();
        },
        child: const Icon(
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
            ),
          ),
        ]),
      ),
    );
  }
}

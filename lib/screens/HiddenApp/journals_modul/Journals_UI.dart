import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:magic_calculator/data/dataBase/DataBase.dart';

import '../../../data/JSON_FILS/Journal_JSON.dart';
import '../../../widgets/Journal_item_ui.dart';
import '../../../widgets/drawer.dart';
import 'Add_Journal.dart';

class Journals_UI extends StatefulWidget {
  @override
  State<Journals_UI> createState() => _Journals_UIState();
}

class _Journals_UIState extends State<Journals_UI> {
  String date = DateFormat.yMMMEd().format(DateTime.now());

  List l = [];

  @override
  Widget build(BuildContext context) {
    double screenHight = MediaQuery.of(context).size.height;
    // print(JournalList.length);
    String Hello = "${'Hello,'.tr()} ${'it is'.tr()}";

    return Scaffold(
      appBar: AppBar(
        title: Text("Journal".tr()),
        backgroundColor: const Color(0xffFF7276),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  onTap: () {
                    JournalList.isNotEmpty
                        ? {
                            magicDataBase()
                                .deleteTableData(table: Tables.journals),
                            JournalList.clear(),
                            setState(() {})
                          }
                        : {};
                  },
                  child: ListTile(
                    minLeadingWidth: 5,
                    leading: Icon(Icons.delete,
                        color: JournalList.isNotEmpty
                            ? Colors.grey[800]
                            : Colors.grey[400]),
                    title: Text(
                      'Delete All'.tr(),
                      style: TextStyle(
                          color: JournalList.isNotEmpty
                              ? Colors.grey[800]
                              : Colors.grey[500]),
                    ),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      drawer: drawer(const Color(0xaaFF7276)),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffFF7276),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Add_Journal()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
        height: screenHight,
        child: ListView(
          children: [
            Row(
              children: [
                Text(
                  Hello,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xffFF7276),
                  ),
                )
              ],
            ),
            journalsList(screenHight),
          ],
        ),
      ),
    );
  }
}

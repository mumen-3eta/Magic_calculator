import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:magic_calculator/data/JSON_FILS/Note_JSON.dart';
import 'package:magic_calculator/data/dataBase/DataBase.dart';
import 'package:magic_calculator/screens/HiddenApp/notes_modul/Add_Note.dart';

import '../../../widgets/Note_item_ui.dart';
import '../../../widgets/drawer.dart';

class Notes_UI extends StatefulWidget {
  @override
  State<Notes_UI> createState() => _Notes_UIState();
}

class _Notes_UIState extends State<Notes_UI> {
  String date = DateUtils.dateOnly(DateTime.now()).toString().substring(0, 10);

  @override
  Widget build(BuildContext context) {
    double screenHieght = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Notes".tr()),
        backgroundColor: Color(0xff82E0C8),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  onTap: () {
                    noteList.isNotEmpty
                        ? {
                            magicDataBase()
                                .deleteTableData(table: Tables.notes),
                            noteList.clear(),
                            setState(() {})
                          }
                        : {};
                  },
                  child: ListTile(
                    minLeadingWidth: 5,
                    leading: Icon(Icons.delete,
                        color: noteList.isNotEmpty
                            ? Colors.grey[800]
                            : Colors.grey[400]),
                    title: Text(
                      "Delete All".tr(),
                      style: TextStyle(
                          color: noteList.isNotEmpty
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff82E0C8),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Add_Note()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      drawer: drawer(Color(0xaa82E0C8)),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
        height: screenHieght,
        child: ListView(
          children: [
            Wrap(
              children: [
                Text(
                  "Note_wisdom_1".tr(),
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  "Note_wisdom_2".tr(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 13, 176, 135),
                  ),
                ),
                Text(
                  "Note_wisdom_3".tr(),
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  "Note_wisdom_4".tr(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff82E0C8),
                  ),
                ),
              ],
            ),
            NoteGridList(screenHieght),
          ],
        ),
      ),
    );
  }
}

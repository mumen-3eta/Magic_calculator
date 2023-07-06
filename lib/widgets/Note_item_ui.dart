import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:magic_calculator/screens/HiddenApp/notes_modul/Edit_Note.dart';

import '../data/JSON_FILS/Note_JSON.dart';
import '../data/dataBase/DataBase.dart';
import '../screens/HiddenApp/notes_modul/note.dart';

class NoteGridList extends StatefulWidget {
  double screenHieght;
  NoteGridList(this.screenHieght);

  @override
  State<NoteGridList> createState() => _NoteGridListState();
}

class _NoteGridListState extends State<NoteGridList> {
  List l = [];

  @override
  Widget build(BuildContext context) {
    getNotesDataFromDB();
    return FutureBuilder<List>(
      future: magicDataBase().readData(tableName: Tables.journals),
      builder: (context, snapshot) {
        // getNotesDataFromDB();
        return noteList.isNotEmpty
            ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                padding: const EdgeInsets.symmetric(vertical: 8),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: noteList.length,
                itemBuilder: ((context, input) {
                  int index = noteList.length - (input + 1);
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => note(index)));
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 0,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: GridTile(
                            footer: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Edit_Note(index)));
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.grey,
                                    size: 24,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    magicDataBase().deleteData(
                                        table: Tables.notes,
                                        id: noteList[index].id!);
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.grey,
                                    size: 24,
                                  ),
                                )
                              ],
                            ),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    noteList[index].heading!.length < 18
                                        ? noteList[index].heading!
                                        : '${noteList[index].heading!.substring(0, 17)}...',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const Divider(
                                    color: null,
                                  ),
                                  Text(
                                    noteList[index].content!.length < 29
                                        ? noteList[index].content!
                                        : '${noteList[index].content!.substring(0, 30)}...',
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        // margin:  const EdgeInsets.symmetric(vertical: 2, horizontal: 1),
                        child: Localizations.override(
                          context: context,
                          locale: Locale('en'),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SvgPicture.asset(
                                'assets/svgs/note.svg',
                                height: 30,
                                width: 28,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              )
            : Container(
                height: widget.screenHieght / 1.5,
                child: Lottie.asset('assets/animations/empty_note.json'));
      },
    );
  }
}

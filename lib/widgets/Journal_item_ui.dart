import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../data/JSON_FILS/Journal_JSON.dart';
import '../data/dataBase/DataBase.dart';
import '../screens/HiddenApp/journals_modul/Edit_Journal.dart';
import '../screens/HiddenApp/journals_modul/diary.dart';

class journalsList extends StatelessWidget {
  double screenHieght;
  journalsList(this.screenHieght);

  @override
  Widget build(BuildContext context) {
    getJournalsDataFromDB();
    return FutureBuilder<List>(
        future: magicDataBase().readData(tableName: Tables.journals),
        builder: (context, snapshot) {
          getJournalsDataFromDB();
          return JournalList.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: JournalList.length,
                  itemBuilder: ((context, input) {
                    int index = JournalList.length - (input + 1);

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return diary(index);
                        }));
                      },
                      child: Container(
                        height: 100,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 0.5,
                              blurRadius: 0.5,
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Text(
                              JournalList[index].heading!.length < 18
                                  ? JournalList[index].heading!
                                  : '${JournalList[index].heading!.substring(0, 17)}...',
                            ),
                          ),
                          subtitle: Text(
                            DateFormat.yMMMd()
                                .format(JournalList[index].dateTime!),
                            style:
                                const TextStyle(color: const Color(0xffFF7276)),
                          ),
                          trailing: Container(
                            margin: const EdgeInsets.symmetric(vertical: 15.0),
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  DateFormat.jm()
                                      .format(JournalList[index].dateTime!),
                                  style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w300),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                InkWell(
                                    splashColor: Colors.grey,
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Edit_Journal(index)));
                                    },
                                    child: const Icon(Icons.edit)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                )
              : Container(
                  height: screenHieght / 1.5,
                  child: Lottie.asset('assets/animations/empty_journals.json'));
        });
  }
}

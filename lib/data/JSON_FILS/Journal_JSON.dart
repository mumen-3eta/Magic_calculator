import 'dart:ui';

import '../dataBase/DataBase.dart';
import '../dataClasses/Journals.dart';

Map<String, dynamic> journals = {
  'name': 'Journal',
  'date': DateTime(0),
  'color': const Color(0xffFF7276),
};

List<Journal> JournalList = [];

getJournalsDataFromDB() async {
  List<Map<String, dynamic>> Journals =
      await magicDataBase().readData(tableName: Tables.journals);
  JournalList = Journals.map((e) => Journal.fromJson(e)).toList();
}

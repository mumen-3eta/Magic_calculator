import 'dart:ui';

import 'package:magic_calculator/data/dataClasses/Notes.dart';
import 'package:magic_calculator/screens/HiddenApp/notes_modul/note.dart';

import '../dataBase/DataBase.dart';

Map<String, dynamic> notes = {
  'name': 'Notes',
  'date': DateTime(0),
  'color': const Color(0xff82E0C8),
};

List<Note> noteList = [];

getNotesDataFromDB() async {
  List<Map<String, dynamic>> Notes =
      await magicDataBase().readData(tableName: Tables.notes);
  noteList = Notes.map((e) => Note.fromJson(e)).toList();
}

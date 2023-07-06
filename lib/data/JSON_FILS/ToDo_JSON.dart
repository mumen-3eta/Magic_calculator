import 'dart:collection';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';

import '../dataBase/DataBase.dart';
import '../dataClasses/Todos.dart';

Map<String, dynamic> tasks = {
  'name': 'To-Do',
  'date': DateTime(0),
  'color': const Color(0xff8E8BFF),
};

List<Task> TasksList = [];

getTasksDataFromDB() async {
  List<Map<String, dynamic>> Tasks =
      await magicDataBase().readData(tableName: Tables.tasks);
  TasksList = Tasks.map((e) => Task.fromJson(e)).toList();

  TasksList.sort(((a, b) {
    if ((a.isDone! && b.isDone!) || (!a.isDone! && !b.isDone!)) {
      return 0;
    } else if (a.isDone! && !b.isDone!) {
      return -1;
    } else {
      return 1;
    }
  }));
}

import 'package:magic_calculator/data/dataClasses/Todos.dart';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';

import '../dataClasses/Journals.dart';
import '../dataClasses/Notes.dart';

class Tables {
  static const String journals = 'journals';
  static const String notes = 'notes';
  static const String tasks = 'tasks';
}

class magicDataBase {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await createDatabase();
      return _db;
    } else {
      return _db;
    }
  }

  createDatabase() async {
    String DBpath = await getDatabasesPath();
    String path = join(DBpath, 'magicDB');
    Database database =
        await openDatabase(path, version: 1, onCreate: _onCreate);
    return database;
  }

  _onCreate(Database db, int v) async {
    await db.execute('''
  CREATE TABLE journals (
    'id' INTEGER PRIMARY KEY AUTOINCREMENT,
    'heading' TEXT NOT NULL,
    'content' TEXT,
    'datetime' TEXT
  );''');
    await db.execute('''

  CREATE TABLE notes (
    'id' INTEGER PRIMARY KEY AUTOINCREMENT,
    'heading' TEXT NOT NULL,
    'content' TEXT,
    'datetime' TEXT
  );''');
    await db.execute('''

  CREATE TABLE tasks (
    'id' INTEGER PRIMARY KEY AUTOINCREMENT,
    'task' TEXT NOT NULL,
    'isDone' INTEGER NOT NULL DEFAULT 0
  );
''');
    print("Created!");
  }

  Future<List<Map<String, dynamic>>> readData(
      {required String tableName}) async {
    Database? magicDB = await db;
    List<Map<String, dynamic>> response =
        await magicDB!.rawQuery("SELECT * FROM $tableName");

    return response;
  }

  addData({required String table, required Object app}) async {
    switch (table) {
      case Tables.journals:
        Journal journal = app as Journal;
        String values =
            "'${journal.heading}' , '${journal.content}' , '${journal.datetime()}'";
        String columns = "heading, content, datetime";
        Database? magicDB = await db;
        int response = await magicDB!.rawInsert(
            "INSERT INTO ${Tables.journals}($columns) VALUES($values); ");
        return response;
      case Tables.notes:
        Note note = app as Note;
        String values =
            "'${note.heading}' , '${note.content}' , '${note.datetime()}'";
        String columns = "heading, content, datetime";
        Database? magicDB = await db;
        int response = await magicDB!.rawInsert(
            "INSERT INTO ${Tables.notes}($columns) VALUES($values); ");

        return response;
      case Tables.tasks:
        Task task = app as Task;
        String values = "'${task.task}'";
        String columns = "task";
        Database? magicDB = await db;
        int response = await magicDB!.rawInsert(
            "INSERT INTO ${Tables.tasks}($columns) VALUES($values); ");

        return response;
    }
  }

  updateData(
      {required String table, required Object app, required int id}) async {
    switch (table) {
      case Tables.journals:
        Journal journal = app as Journal;

        Database? magicDB = await db;
        int response = await magicDB!.rawUpdate('''
            UPDATE ${Tables.journals} SET heading = '${journal.heading}',
                                          content = '${journal.content}',
                                          datetime = '${journal.datetime()}'
            WHERE id = ${id};   
                                             ''');

        return response;

      case Tables.notes:
        Note note = app as Note;

        Database? magicDB = await db;
        int response = await magicDB!.rawUpdate('''
            UPDATE ${Tables.notes} SET heading = '${note.heading}',
                                          content = '${note.content}',
                                          datetime = '${note.datetime()}'
            WHERE id = ${id};   
                                             ''');

        return response;
      case Tables.tasks:
        Task task = app as Task;

        Database? magicDB = await db;
        int response = await magicDB!.rawUpdate('''
            UPDATE ${Tables.tasks} SET task = '${task.task}',
                                          isDone = '${task.isdone()}'
            WHERE id = ${id};   
                                             ''');

        return response;
    }
  }

  deleteData({required String table, required int id}) async {
    Database? magicDB = await db;
    int response =
        await magicDB!.rawDelete("DELETE FROM ${table} WHERE id = '${id}'; ");
    return response;
  }

  deleteTableData({required String table}) async {
    Database? magicDB = await db;
    int response = await magicDB!.rawDelete("DELETE FROM ${table} ; ");
    return response;
  }
}

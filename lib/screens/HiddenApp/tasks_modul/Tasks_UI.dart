import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:magic_calculator/data/JSON_FILS/ToDo_JSON.dart';

import '../../../data/JSON_FILS/Note_JSON.dart';
import '../../../data/dataBase/DataBase.dart';
import '../../../data/dataClasses/Todos.dart';
import '../../../widgets/Task_item_ui.dart';
import '../../../widgets/drawer.dart';

class Tasks_UI extends StatefulWidget {
  @override
  State<Tasks_UI> createState() => _Tasks_UIState();
}

class _Tasks_UIState extends State<Tasks_UI> {
  @override
  Widget build(BuildContext context) {
    double screenHight = MediaQuery.of(context).size.height;

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("To-Do".tr()),
        backgroundColor: const Color(0xff8E8BFF),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  onTap: () {
                    TasksList.isNotEmpty
                        ? {
                            magicDataBase()
                                .deleteTableData(table: Tables.tasks),
                            TasksList.clear(),
                            setState(() {})
                          }
                        : {};
                  },
                  child: ListTile(
                    minLeadingWidth: 5,
                    leading: Icon(Icons.delete,
                        color: TasksList.isNotEmpty
                            ? Colors.grey[800]
                            : Colors.grey[400]),
                    title: Text(
                      "Delete All".tr(),
                      style: TextStyle(
                          color: TasksList.isNotEmpty
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
      drawer: drawer(const Color(0xaa8E8BFF)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialogAdd(context);
        },
        backgroundColor: const Color(0xff8E8BFF),
        child: const Icon(Icons.add),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
        height: screenHight,
        child: ListView(
          children: [
            Wrap(
              children: [
                Text(
                  "Task_wisdom_1".tr(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Task_wisdom_2".tr(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xff4F8AFF),
                  ),
                ),
                Text(
                  "Task_wisdom_3".tr(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Task_wisdom_4".tr(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xff8E8BFF),
                  ),
                ),
              ],
            ),
            tasksList(screenHight),
          ],
        ),
      ),
    );
  }

  showDialogAdd(BuildContext context) {
    TextEditingController controller = TextEditingController();

    String? task;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Container(
              child: Text("Add new task".tr()),
            ),
            content: TextField(
              controller: controller,
            ),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Text(
                    "Cancel".tr(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  String taskString = controller.text;
                  taskString.isNotEmpty
                      ? {
                          magicDataBase().addData(
                              table: Tables.tasks, app: Task(taskString)),
                          tasks['date'] = DateTime.now()
                        }
                      : {};

                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Text(
                    "Add".tr(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          );
        });
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../data/JSON_FILS/ToDo_JSON.dart';
import '../data/dataBase/DataBase.dart';
import '../data/dataClasses/Todos.dart';

class tasksList extends StatefulWidget {
  double screenHieght;
  tasksList(this.screenHieght);
  @override
  State<tasksList> createState() => _tasksListState();
}

class _tasksListState extends State<tasksList> {
  @override
  Widget build(BuildContext context) {
    getTasksDataFromDB();
    return FutureBuilder<List>(
        future: magicDataBase().readData(tableName: Tables.journals),
        builder: (context, snapshot) {
          getTasksDataFromDB();

          return TasksList.isEmpty
              ? Container(
                  height: widget.screenHieght / 1.5,
                  child: Lottie.asset('assets/animations/empty_todo.json'))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: (TasksList).length,
                  itemBuilder: ((context, input) {
                    int index = TasksList.length - (input + 1);

                    return Container(
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
                      child: InkWell(
                        onTap: () {
                          TasksList[index].isDone = !TasksList[index].isDone!;
                          magicDataBase().updateData(
                              table: Tables.tasks,
                              app: TasksList[index],
                              id: TasksList[index].id!);
                          getTasksDataFromDB();

                          setState(() {});
                        },
                        child: ListTile(
                          leading: IgnorePointer(
                            child: Checkbox(
                              hoverColor: Colors.red,
                              activeColor: Colors.green,
                              onChanged: (value) {},
                              value: TasksList[index].isDone,
                            ),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Text(
                              TasksList[index].task.length < 18
                                  ? TasksList[index].task
                                  : '${TasksList[index].task.substring(0, 17)}...',
                              style: TextStyle(
                                  decoration: TasksList[index].isDone!
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none),
                            ),
                          ),
                          trailing: SizedBox(
                            width: 60,
                            child: Row(
                              children: [
                                InkWell(
                                    splashColor: Colors.grey,
                                    onTap: () {
                                      showDialogEdit(context, index);
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.grey,
                                      size: 30,
                                    )),
                                InkWell(
                                    splashColor: Colors.grey,
                                    onTap: () {
                                      magicDataBase().deleteData(
                                          table: Tables.tasks,
                                          id: TasksList[index].id!);

                                      setState(() {});
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.grey,
                                      size: 30,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                );
        });
  }

  showDialogEdit(BuildContext context, int index) {
    TextEditingController controller = TextEditingController();
    controller.text = TasksList[index].task;

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Container(
              child: Text("Edit Task".tr()),
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
                  Task task = TasksList[index];
                  taskString.isNotEmpty ? task.task = taskString : {};
                  magicDataBase().updateData(
                      table: Tables.tasks, app: task, id: TasksList[index].id!);

                  setState(() {});
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Text(
                    "Submit".tr(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          );
        });
  }
}

class Task {
  int? id;
  String task = '';
  bool? isDone;

  Task(
    this.task,
  );
  int isdone() {
    return isDone! ? 1 : 0;
  }

  Task.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    task = map['task'];
    isDone = map['isDone'] == 0 ? false : true;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'task': task,
      'isDone': isDone,
    };
    return map;
  }
}

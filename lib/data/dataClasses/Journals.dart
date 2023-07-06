class Journal {
  int? id;
  String? heading = '';
  String? content = '';
  DateTime? dateTime;

  Journal(this.heading, this.content, this.dateTime);

  Journal.fromJson(Map map) {
    id = map['id'];
    heading = map['heading'];
    content = map['content'];
    dateTime = DateTime.tryParse(map['datetime']);
  }

  String datetime() {
    return dateTime.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'heading': heading,
      'content': content,
      'datetime': DateTime.now().toString(),
    };
  }
}

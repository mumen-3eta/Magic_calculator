class Note {
  int? id;
  String? heading = '';
  String? content = '';
  DateTime? dateTime;

  Note(this.heading, this.content, this.dateTime);

  Note.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    heading = map['heading'];
    content = map['content'];
    dateTime = DateTime.parse(map['datetime']);
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

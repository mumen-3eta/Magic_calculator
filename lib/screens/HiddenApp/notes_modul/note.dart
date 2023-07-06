import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:magic_calculator/data/dataBase/DataBase.dart';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';

import '../../../data/JSON_FILS/Note_JSON.dart';
import 'Edit_Note.dart';
import 'Notes_UI.dart';

class note extends StatelessWidget {
  int? size;
  GlobalKey previewContainer = new GlobalKey();
  shareScreen() {
    ShareFilesAndScreenshotWidgets().shareScreenshot(
      previewContainer,
      size!,
      "Share Note",
      "Note.png",
      "image/png",
      text: "This is the Note!",
    );
  }

  int index;
  note(this.index);

  @override
  Widget build(BuildContext context) {
    double screenHight = MediaQuery.of(context).size.height;
    size = screenHight.toInt();

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff82E0C8),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Edit_Note(index)));
          },
          child: const Icon(
            Icons.edit,
            color: Colors.white,
            size: 30,
          ),
        ),
        appBar: AppBar(
          title: Text("Note".tr()),
          backgroundColor: const Color(0xff82E0C8),
          actions: [
            IconButton(
              onPressed: () {
                shareScreen();
              },
              icon: const Icon(
                Icons.share,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                magicDataBase()
                    .deleteData(table: Tables.notes, id: noteList[index].id!);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Notes_UI()));
              },
              icon: const Icon(
                Icons.delete_forever,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: NoteBody(previewContainer));
  }

  Widget NoteBody(previewContainer) {
    return RepaintBoundary(
      key: previewContainer,
      child: Container(
        height: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: ListView(shrinkWrap: true, children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text(
              noteList[index].heading!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Text(noteList[index].content!),
          Divider(),
          Text(
            '${DateFormat.jm().format(noteList[index].dateTime ?? DateTime.now())} - ${DateFormat.yMMMMEEEEd().format(noteList[index].dateTime ?? DateTime.now())}',
            style: TextStyle(color: Color(0xff82E0C8)),
          ),
        ]),
      ),
    );
  }
}

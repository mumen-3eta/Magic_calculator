import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:magic_calculator/data/JSON_FILS/ToDo_JSON.dart';
import 'package:magic_calculator/screens/HiddenApp/Settings.dart';

import 'package:magic_calculator/screens/HiddenApp/journals_modul/Journals_UI.dart';
import 'package:magic_calculator/screens/HiddenApp/tasks_modul/Tasks_UI.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../data/JSON_FILS/Journal_JSON.dart';
import '../../data/JSON_FILS/Note_JSON.dart';
import 'notes_modul/Notes_UI.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Settings()));
              },
            ),
          ],
          backgroundColor: Color(0xff951BDB),
          title: Text('Home'.tr()),
        ),
        body: ListView(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return Journals_UI();
                })));
              },
              child: homeItem(
                  journals,
                  Icon(
                    Icons.book_outlined,
                    size: 17.w,
                  )),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return Notes_UI();
                })));
              },
              child: homeItem(
                  notes,
                  Icon(
                    Icons.note_alt_outlined,
                    size: 17.w,
                  )),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return Tasks_UI();
                })));
              },
              child: homeItem(
                  tasks,
                  Icon(
                    Icons.checklist,
                    size: 17.w,
                  )),
            ),
          ],
        ));
  }

  Widget homeItem(Map<String, dynamic> map, Icon icon) {
    return Container(
      height: 28.h,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      decoration: BoxDecoration(
          color: map['color'],
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Text(
                '${map['name']}'.tr(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
              ),
              Spacer(),
              icon,
            ],
          ),
          Row(
            children: [
              Text(
                "last modify".tr(),
                style: TextStyle(fontSize: 16.sp),
              ),
              Text(
                map['date'] == DateTime(0)
                    ? 'Never'
                    : DateFormat.yMMMMEEEEd().format(map['date']),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

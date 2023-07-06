import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../widgets/Calculator.dart';
import 'HiddenApp/intro_Screens/intro_Screen.dart';

class Magic_calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff951BDB),
        title: Text('Magic Calculator'.tr()),
      ),
      body: Calculator(),
    );
  }
}

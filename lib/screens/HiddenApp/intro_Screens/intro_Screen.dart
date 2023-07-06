import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:magic_calculator/screens/calculator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class intro_Screen extends StatelessWidget {
  TextEditingController operand1_controller = TextEditingController();

  TextEditingController operand2_controller = TextEditingController();

  TextEditingController operand3_controller = TextEditingController();

  page_1(String body) {
    PageViewModel page_1 = PageViewModel(
      title: '',
      bodyWidget: Text(
        body,
        style: TextStyle(fontSize: 21.sp),
        textAlign: TextAlign.center,
      ),
      image: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Image.asset(
          'assets/images/introPageOne.png',
        ),
      ),
    );
    return page_1;
  }

  page_2(String body) {
    PageViewModel page_2 = PageViewModel(
        title: '',
        bodyWidget: Text(
          '${"page_2_body".tr()}',
          style: TextStyle(fontSize: 20.sp),
          textAlign: TextAlign.center,
        ),
        image: Container(
          margin: const EdgeInsets.only(top: 20),
          child: Image.asset('assets/images/introPageTwo.png'),
        ));
    return page_2;
  }

  page_3(String body) {
    PageViewModel page_3 = PageViewModel(
        title: '',
        bodyWidget: Text(
          body,
          style: TextStyle(fontSize: 20.sp),
          textAlign: TextAlign.center,
        ),
        image: Container(
          margin: const EdgeInsets.only(top: 20),
          child: Image.asset('assets/images/introPageThree.png'),
        ));
    return page_3;
  }

  page_4(
    List<TextEditingController> Controllers,
    double screenheight,
  ) {
    PageViewModel page_4 = PageViewModel(
      useScrollView: true,
      titleWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        child: Text(
          "setEquation".tr(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bodyWidget: setPassEquationWidget(
        Controllers,
      ),
      image: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SizedBox(
          height: screenheight / 1.2,
          child: Center(
            child: Text(
              "${'page_4_rule_1'.tr()}  \n${'page_4_rule_2'.tr()} \n${'page_4_rule_3'.tr()}\n${'page_4_rule_4'.tr()}  \n${'page_4_rule_5'.tr()}",
              style: TextStyle(fontSize: 16.sp),
            ),
          ),
        ),
      ),
    );
    return page_4;
  }

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: screenheight,
      color: Colors.white,
      padding: const EdgeInsets.only(top: 50, bottom: 30),
      child: IntroductionScreen(
        globalBackgroundColor: Colors.white,
        next: Icon(Icons.arrow_forward),
        onDone: () async {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          List<String> equation = [
            operand1_controller.text,
            operand2_controller.text,
            operand3_controller.text
          ];

          sharedPreferences.setStringList('passEquation', equation);
          ScaffoldMessenger.of(context).showSnackBar(Snackbar());

          sharedPreferences.setBool('Opened', true);

          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Magic_calculator()));
          print("Done");
        },
        done: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            "Done".tr(),
            style: TextStyle(fontSize: 20.sp),
          ),
        ),
        pages: [
          page_1("page_1_body".tr()),
          page_2("page_2_body".tr()),
          page_3("page_3_body".tr()),
          page_4(
              [operand1_controller, operand2_controller, operand3_controller],
              screenheight),
        ],
      ),
    );
  }
}

setPassEquationWidget(List<TextEditingController> controllers) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Container(
                    width: 70,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      controller: controllers[0],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "First Number".tr(),
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 70,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      controller: controllers[1],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "Sign".tr(),
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 70,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      controller: controllers[2],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "Second Number".tr(),
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Snackbar() {
  return SnackBar(
    content: Text("passEquation Changed".tr()),
    duration: Duration(milliseconds: 2500),
    backgroundColor: Color(0xff0BB300),
  );
}

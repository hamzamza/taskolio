import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front/helpers/colors.dart';
import 'package:front/screens/login_scren.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intro_slider/intro_slider.dart';

class IntroScreenCustomLayout extends StatefulWidget {
  const IntroScreenCustomLayout({Key? key}) : super(key: key);

  @override
  IntroScreenCustomLayoutState createState() => IntroScreenCustomLayoutState();
}

// ------------------ data  ------------------
final List<Map<String, dynamic>> slides = [
  {
    "title": "Task managment",
    "description":
        "Efficiently manage your tasks with Taskol.io. Set deadlines, prioritize tasks, and track progress all in one place.",
    "svgUrl": "assets/icons/1.svg"
  },
  {
    "title": " Create Projects and Share Tasks",
    "description":
        "Create and manage projects effortlessly with Taskol.io. Collaborate with your team and stay on top of your project's progress.",
    "svgUrl": "assets/icons/2.svg"
  },
  {
    "title": "Stay on Top with Notifications",
    "description":
        "Never miss a task or deadline with Taskol.io's notification system. Stay on top of your work with ease.",
    "svgUrl": "assets/icons/4.svg"
  },
  {
    "title": "Security and Encryption",
    "description":
        "We take your security seriously. Taskol.io uses top-of-the-line encryption methods to ensure that your data is safe and secure.",
    "svgUrl": "assets/icons/3.svg"
  },
];

// ------------------ Custom layout ------------------
class IntroScreenCustomLayoutState extends State<IntroScreenCustomLayout> {
  late Function goToTab;

  Color primaryColor = goodRed;
  Color secondColor = goodRed;

  void onDonePress() {
    // TODO: go to login page
    Get.to(LoginScreen());
  }

  void onTabChangeCompleted(index) {
    log("onTabChangeCompleted, index: $index");
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: primaryColor,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: primaryColor,
    );
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 20, vertical: 3)),
      shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder()),
      backgroundColor:
          MaterialStateProperty.all<Color>(const Color.fromARGB(38, 0, 0, 0)),
      overlayColor: MaterialStateProperty.all<Color>(goodRed),
    );
  }

  List<Widget> generateListCustomTabs() {
    return List.generate(
      slides.length,
      (index) => Stack(
        children: [
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Container(
              color: LightGrey,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  SvgPicture.asset(
                    slides[index]["svgUrl"],
                    width: 300.0,
                    height: 300.0,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: const Color.fromARGB(115, 250, 147, 139),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(110, 255, 104, 93)
                                .withOpacity(0.2),
                            spreadRadius: 8,
                            blurRadius: 15,
                            // changes position of shadow
                          ),
                        ]),
                    margin: const EdgeInsets.only(
                        bottom: 5, right: 16, left: 16, top: 5),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: Column(
                      children: [
                        Text(
                          slides[index]["title"],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: LightGrey,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'RobotoMono',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          slides[index]["description"],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Lightwhite,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'RobotoMono',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightGrey,
        elevation: 0,
        title: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    " Taskol.",
                    style: GoogleFonts.robotoMono(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 48,
                    ),
                  ),
                  Text(
                    "io",
                    style: GoogleFonts.robotoMono(
                      color: goodRed,
                      fontWeight: FontWeight.bold,
                      fontSize: 48,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        toolbarHeight: 250,
      ),
      backgroundColor: LightGrey,
      body: IntroSlider(
        key: UniqueKey(),
        // Skip button
        isShowSkipBtn: false,
        isShowPrevBtn: false,
        // Next button
        renderNextBtn: renderNextBtn(),
        nextButtonStyle: myButtonStyle(),

        // Done button
        renderDoneBtn: renderDoneBtn(),
        onDonePress: onDonePress,
        doneButtonStyle: myButtonStyle(),

        // Indicator
        indicatorConfig: const IndicatorConfig(
          colorIndicator: goodRed,
          sizeIndicator: 13.0,
          typeIndicatorAnimation: TypeIndicatorAnimation.sizeTransition,
        ),

        // Custom tabs
        listCustomTabs: generateListCustomTabs(),

        // Behavior
        scrollPhysics: const BouncingScrollPhysics(),
      ),
    );
  }
}

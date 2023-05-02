import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front/Models/category.dart';
import 'package:front/Models/list.dart';
import 'package:front/Models/project.dart';
import 'package:front/Models/user.dart';
import 'package:front/controllers/auth_controller.dart';
import 'package:front/controllers/screens_controller.dart';
import 'package:front/screens/intro_slider.dart';
import 'package:front/screens/main_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  Get.put(ScreenController());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent));
  await dotenv.load();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskListAdapter());
  Hive.registerAdapter(ProjectAdapter());
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(UserAdapter());
// handel logedin or logedout
// passe the is logedin as a params into run app

  var isauth = await User.getToken();
  var logedin = isauth != null ? true : false;
  Get.put(AuthController());
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition:
          Transition.circularReveal, // set a default transition for all routes
      transitionDuration: const Duration(milliseconds: 300),
      theme: ThemeData(
        primarySwatch: Colors.grey,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          foregroundColor: Colors.black,
        ),
      ),
      home: logedin ? const MainScreen() : const IntroScreenCustomLayout(),
    ),
  );
}
//comments line
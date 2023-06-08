
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front/Models/category.dart';
import 'package:front/Models/list.dart';
import 'package:front/Models/project.dart';
import 'package:front/Models/task.dart';
import 'package:front/controllers/auth_controller.dart';
import 'package:front/helpers/DurationAdapter.dart';

import 'package:front/helpers/colors.dart';
import 'package:front/screens/ListTask.dart';
import 'package:front/screens/ProjectScreen.dart';

import 'package:front/screens/main_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:front/screens/profile_screen.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'helpers/ColorAdapter.dart';
import 'helpers/SectionAdapter.dart';
import 'screens/welcome_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent));
  await dotenv.load();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskListAdapter());
  Hive.registerAdapter(ProjectAdapter());
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(SectionAdapter());
  Hive.registerAdapter(ColorAdapter());
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(DurationAdapter());
  //Hive.registerAdapter(RoleAdapter());
  //Hive.registerAdapter(TaskAdapter());
  //Hive.registerAdapter(RepetationAdapter());
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition:
      Transition.cupertino, // set a default transition for all routes
      transitionDuration: Duration(milliseconds: 800),
      routes: {
        '/list_task': (context) => ListTask(),
        '/project_task':(context)=>ProjectScreen()
      },
      theme: ThemeData(
        primarySwatch: Colors.grey,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          foregroundColor: Colors.black,
        ),
      ),
      home: const App(),
      builder: EasyLoading.init(),
    ),
  );
  //configLoading();
  //EasyLoading.init();
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    //final AuthController authController = Get.put(AuthController());
    //authController.checkAuth();
    return Container(child: Scaffold(
      body: MainScreen(),
      backgroundColor: LightGrey,
    ) /*
          * (auth.IsLogedin
          ? const ProfileScreen()
          : const Scaffold(
        body: WelcomeScreen(),
        backgroundColor: LightGrey,
      ));*/
    );
  }
}
void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false
    ..indicatorColor = Colors.green;
}
// ipAddress : 192.168.1.105
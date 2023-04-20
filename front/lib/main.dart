import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front/Models/category.dart';
import 'package:front/Models/list.dart';
import 'package:front/Models/project.dart';
import 'package:front/Models/task.dart';
import 'package:front/controllers/auth_controller.dart';
import 'package:front/controllers/screens_controller.dart';
import 'package:front/helpers/colors.dart';
import 'package:front/screens/main_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:front/screens/profile_screen.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'screens/welcome_screen.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent));
  await dotenv.load();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskListAdapter());
  Hive.registerAdapter(ProjectAdapter());
  Hive.registerAdapter(CategoryAdapter());
  await Hive.openBox('categories');
  await Hive.openBox('projects');

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition:
          Transition.cupertino, // set a default transition for all routes
      transitionDuration: Duration(milliseconds: 800),
      theme: ThemeData(
        primarySwatch: Colors.grey,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          foregroundColor: Colors.black,
        ),
      ),
      home: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    authController.checkAuth();
    return Container(child: GetBuilder<AuthController>(builder: (auth) {
      return (auth.IsLogedin
          ? const ProfileScreen()
          : const Scaffold(
              body: WelcomeScreen(),
              backgroundColor: LightGrey,
            ));
    }));
  }
}
// ipAddress : 192.168.1.105
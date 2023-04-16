import 'package:flutter/material.dart';
import 'package:front/controllers/auth_controller.dart';
import 'package:front/controllers/screens_controller.dart';
import 'package:front/helpers/colors.dart';
import 'package:front/screens/main_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'screens/welcome_screen.dart';

void main() async {
  await dotenv.load();
  await Hive.initFlutter();
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
    final ScreenController screenController = Get.put(ScreenController());
    final AuthController authController = Get.put(AuthController());
    authController.checkAuth();
    return Container(child: GetBuilder<AuthController>(builder: (auth) {
      return (auth.IsLogedin
          ? const MainScreen()
          : const Scaffold(
              body: WelcomeScreen(),
              backgroundColor: LightGrey,
            ));
    }));
  }
}
// ipAddress : 192.168.1.105
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front/Models/category.dart';
import 'package:front/Models/list.dart';
import 'package:front/Models/project.dart';
import 'package:front/Models/task.dart';
import 'package:front/Models/user.dart';
import 'package:front/controllers/auth_controller.dart';
import 'package:front/controllers/screens_controller.dart';
import 'package:front/helpers/colors.dart';
import 'package:front/screens/main_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:front/screens/profile_screen.dart';
import 'package:front/test/testscreen.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'screens/welcome_screen.dart';

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

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition:
          Transition.cupertino, // set a default transition for all routes
      transitionDuration: const Duration(milliseconds: 800),
      theme: ThemeData(
        primarySwatch: Colors.grey,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          foregroundColor: Colors.black,
        ),
      ),
      home: const Main(),
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
          ? const MainScreen()
          : const Scaffold(
              body: WelcomeScreen(),
              backgroundColor: LightGrey,
            ));
    }));
  }
}
// ipAddress : 192.168.1.105

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  bool isAuthenticated = true;
  bool isloading = true;

  void checkAuth() async {
    setState(() {
      isloading = true;
    });
    var isauth = await User.getToken();
    var logedin = isauth != null ? false : false;

    setState(() {
      isAuthenticated = logedin;
      isloading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    isloading = true;
    checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    return Container(
      child: isloading
          ? Scaffold(
              body: Center(
                  child: Container(
                height: 160,
                child: const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                ),
              )),
            )
          : isAuthenticated
              ? const MainScreen()
              : const Scaffold(
                  body: WelcomeScreen(),
                  backgroundColor: LightGrey,
                ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:front/screens/todys_screen.dart';

import 'package:get/get_navigation/get_navigation.dart';

void main() {
  runApp(
    const GetMaterialApp(
      home: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const TodysScreen();
  }
}

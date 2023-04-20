import 'package:flutter/material.dart';

import 'package:front/screens/list_screen.dart';
import 'package:front/widgets/menu_fullscreen.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  /// this is the first screen  , the gool of this screen is just to handel
  ///  the first frame  of the app it should show modal botom sheet automaticly ,
  /// then you can switch the sceen you want from the navbar list
  @override
  Widget build(BuildContext context) {
    return ListScreen();
  }
}

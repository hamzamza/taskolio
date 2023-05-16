import 'package:flutter/material.dart';
import 'package:front/screens/list_screen.dart';
import 'package:front/test/testController.dart';
import 'package:front/widgets/menu_fullscreen.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _showModalBottomSheet = true;

  @override
  void initState() {
    super.initState();
    _checkIfFirstRun();
  }

  void _checkIfFirstRun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasShownModalBottomSheet =
        prefs.getBool('hasShownModalBottomSheet') ?? false;
    setState(() {
      _showModalBottomSheet = !hasShownModalBottomSheet;
    });
  }

  void _markModalBottomSheetAsShown() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasShownModalBottomSheet', true);
  }

  @override
  Widget build(BuildContext context) {
    if (_showModalBottomSheet) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10.0),
            ),
          ),
<<<<<<< HEAD
          builder: (builder) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.96,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(2))),
                      ),
=======
        ),
        builder: (builder) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.96,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(2))),
>>>>>>> backendbranch
                    ),
                  ),
                  // here you can put the child
                  MenuFullScreen(),
                ],
              ),
            );
          },
        ).whenComplete(() => _markModalBottomSheetAsShown());
      });
    }

    return const ListScreen();
  }
}

import 'package:flutter/material.dart';

import 'package:front/screens/list_screen.dart';
import 'package:front/test/testController.dart';
import 'package:front/widgets/menu_fullscreen.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  /// this is the first screen  , the gool of this screen is just to handel
  ///  the first frame  of the app it should show modal botom sheet automaticly ,
  /// then you can switch the sceen you want from the navbar list
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
=======
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
        builder: (builder) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.96,
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      runtest();
                    },
                    child: Text("run test")),
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
                  ),
                ),
                // here you can put the child
                MenuFullScreen(),
              ],
            ),
          );
        },
      );
    });

>>>>>>> 17624271be16d95e3ba8ca50c3f47905bc44db2e
    return ListScreen();
  }
}

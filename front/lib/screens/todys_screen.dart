import 'package:flutter/material.dart';
import 'package:front/widgets/menu_fullscreen.dart';

class TodysScreen extends StatelessWidget {
  const TodysScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10.0),
          ),
        ),
        builder: (builder) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
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
              // here you can put the child here
              MenuFullScreen(),
            ],
          );
        },
      );
    });

    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Center(child: Text("text")),
    ));
  }
}

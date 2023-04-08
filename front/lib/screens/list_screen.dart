import 'package:flutter/material.dart';
import 'package:front/controllers/screens_controller.dart';
import 'package:front/widgets/menu_bottom.dart';
import 'package:get/get.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenController screenConctroller = Get.find();
    int listindex = screenConctroller.selectedScreen;
    return WillPopScope(
        onWillPop: () async {
          return false; // returning false will do nothing
        },
        child: Scaffold(
          body: ListView.builder(
              itemCount: 26,
              itemBuilder: (BuildContext context, int index) {
                return ListCadrd();
              }),
          appBar: AppBar(
            actions: [
              PopupMenuButton(
                  elevation: 4,
                  shadowColor: const Color.fromARGB(87, 0, 0, 0),
                  // add icon, by default "3 dot" icon
                  iconSize: 30,
                  // icon: Icon(Icons.book)
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem<int>(
                        value: 0,
                        child: Text("Selectionner des Tâches "),
                      ),
                    ];
                  },
                  onSelected: (value) {}),
            ],
            elevation: 0,
            backgroundColor: Colors.white,
            title: Row(
              children: const [
                Icon(Icons.text_snippet_rounded),
                SizedBox(
                  width: 20,
                ),
                Text("salam")
              ],
            ),
          ),
          bottomNavigationBar: Container(height: 70, child: const Menubottom()),
        ));
  }
}

ElevatedButton ListCadrd() => ElevatedButton(
      onPressed: () {},
      style: elevatedbuttonStyle(),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(children: [
          Transform.scale(
            scale: 1.3,
            child: Checkbox(
              fillColor: MaterialStateProperty.resolveWith(getColor),
              shape: const CircleBorder(),
              value: false,
              onChanged: (bool? value) {},
            ),
          ),
          Text('data')
        ]),
      ),
    );

ButtonStyle elevatedbuttonStyle() => ElevatedButton.styleFrom(
      foregroundColor: Colors.black87,
      backgroundColor: Colors.white,
      alignment: Alignment.centerLeft,
      elevation: 0,
      padding: EdgeInsets.zero,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );

Color getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.grey;
  }
  return Colors.black;
}

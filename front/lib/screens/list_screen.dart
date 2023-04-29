import 'package:flutter/material.dart';
import 'package:front/controllers/categorie_controller.dart';
import 'package:front/controllers/screens_controller.dart';
import 'package:front/widgets/menu_bottom.dart';
import 'package:get/get.dart';

import '../helpers/colors.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CategorieController controller = Get.put(CategorieController());
    ScreenController screenConctroller = Get.find();
    int listindex = screenConctroller.selectedScreen;
    return WillPopScope(
        onWillPop: () async {
          return false; // Return false to disable the back button
        },
        child: Scaffold(
          body: Stack(
            children: [
              ListView.builder(
                  itemCount: 26,
                  itemBuilder: (BuildContext context, int index) {
                    return ListCadrd();
                  }),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SizedBox(height: 70, child: Menubottom()),
              ),
              Positioned(
                  bottom: 40,
                  right: 0,
                  left: 0,
                  child: Center(
                      child: Transform.scale(
                    scale: 1.2,
                    child: DragTarget(builder: (_, __, ___) {
                      return Obx(
                        () => Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100)),
                              border: Border.all(color: Colors.red, width: 2)),
                          child: controller.deleting.value
                              ? ClickedIcon(Icon(Icons.delete), 10, () {})
                              : ClickedIcon(const Icon(Icons.add), 10, () {
                                  controller.showDialogWithInputs(context);
                                }),
                        ),
                      );
                    }),
                  )))
            ],
          ),
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
            automaticallyImplyLeading: false,
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

ClickedIcon(Icon icon, double padding, Function whenClickDo) {
  CategorieController controller = Get.put(CategorieController());

  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        foregroundColor: Colors.black87,
        backgroundColor: controller.deleting.value ? Colors.red : Lightwhite,
        alignment: Alignment.centerLeft,
        elevation: 0,
        padding: EdgeInsets.all(padding),
        minimumSize: Size.zero),
    onPressed: () {
      whenClickDo();
    },
    child: Container(
      child: icon,
    ),
  );
}

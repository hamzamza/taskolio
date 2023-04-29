import 'package:flutter/material.dart';
import 'package:front/helpers/colors.dart';
import 'package:front/widgets/menu_fullscreen.dart';
import 'package:get/get.dart';

import '../controllers/categorie_controller.dart';

class Menubottom extends StatelessWidget {
  Menubottom({super.key});
  CategorieController controller = Get.put(CategorieController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Lightwhite,
      child: Stack(clipBehavior: Clip.none, children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Transform.scale(
                scale: 1.2,
                child: ClickedIcon(const Icon(Icons.menu), 10, () {
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
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Center(
                                  child: Container(
                                    width: 40,
                                    height: 4,
                                    decoration: const BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2))),
                                  ),
                                ),
                              ),
                              // here you can put the child
                              MenuFullScreen(),
                            ],
                          ),
                        );
                      });
                })),
            Row(
              children: [
                ClickedIcon(const Icon(Icons.search), 10, () {}),
                ClickedIcon(
                    const Icon(Icons.notifications_active_outlined), 10, () {}),
              ],
            )
          ]),
        ),
      ]),
    );
  }

  ClickedIcon(Icon icon, double padding, Function whenClickDo) =>
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            foregroundColor: Colors.black87,
            backgroundColor:
                controller.deleting.value ? Colors.red : Lightwhite,
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

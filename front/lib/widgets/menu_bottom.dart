import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:front/Models/category.dart';
import 'package:front/controllers/TaskController.dart';
import 'package:front/helpers/colors.dart';
import 'package:front/widgets/CreateTask.dart';
import 'package:front/widgets/Menu/ShowRepeatMenu.dart';
import 'package:front/widgets/menu_fullscreen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import '../controllers/categorie_controller.dart';


class Menubottom extends StatelessWidget {
  Menubottom({this.from_category=false,this.from_list=false,this.from_project=false});
  bool from_project;
  bool from_category;
  bool from_list;
  TaskController taskController = Get.put(TaskController());
  categorieController controller=Get.put(categorieController());
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
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Center(
                                child: Container(
                                  width: 40,
                                  height: 4,
                                  decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(2))),
                                ),
                              ),
                            ),
                            // here you can put the child
                            MenuFullScreen(),
                          ],
                        ),
                      );
                    });
              }),
              scale: 1.2,
            ),
            Row(
              children: [
                ClickedIcon(const Icon(Icons.search), 10, () {}),
                ClickedIcon(
                    const Icon(Icons.notifications_active_outlined), 10, () {}),
              ],
            )
          ]),
        ),
        DragTarget<Category>(builder: (_, __, ___) {
                return Obx(
                  () => Center(
                        child: Transform.scale(
                          scale: 1.2,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(100)),
                                  border: Border.all(color: Colors.red, width: 2)),
                                 child: controller.deleting.value
                                ? ClickedIcon(Icon(Icons.delete), 10, () {})
                                : ClickedIcon(const Icon(Icons.add), 10, () {
                                    if(from_project){
                                       CreateTaskView(context: context,taskController: taskController,InProject: true);
                                    }
                                    else if(from_list){
                                      CreateTaskView(context: context,taskController: taskController,InList: true);
                                    }
                                    else if(from_category){
                                      CreateTaskView(context: context,taskController: taskController,InCategory: true);
                                       }
                                     }
                                   ),
                          ),
                        ),
                      ),

                );
              },
                   onAccept: (Category category){
                       print('delete is called ${category.id}');
                       Category.deleteCategory(category.id);
                       controller.fetchCategories();
                   },
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

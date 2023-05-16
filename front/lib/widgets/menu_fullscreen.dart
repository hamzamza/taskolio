import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:front/controllers/screens_controller.dart';
import 'package:front/helpers/colors.dart';
import 'package:front/screens/category_screen.dart';
import 'package:front/screens/list_screen.dart';
import 'package:get/get.dart';

class MenuFullScreen extends StatelessWidget {
  ScreenController screenConctroller = Get.put(ScreenController());
  MenuFullScreen({super.key});
  late int productivity = 6;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Color.fromARGB(255, 189, 189, 189), width: 1))),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black87,
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              onPressed: () {},
              child: Container(
                padding: const EdgeInsets.only(bottom: 10, top: 2),
                child: Row(
                  children: [
                    Rownedimage('assets/images/user_image.jpeg'),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Hamza Douaij",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5)),
                        const SizedBox(
                          height: 3,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              const Icon(Icons.show_chart_sharp,
                                  color: Colors.red),
                              Text("   $productivity /10",
                                  style: TextStyle(
                                      color: Colors.green[600],
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: -1))
                            ],
                          ),
                        )
                      ],
                    ),
                    Expanded(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(0),
                              child: const Icon(
                                Icons.settings_outlined,
                                size: 25,
                              ),
                            ),
                          ),
                        ]))
                  ],
                ),
              ),
            ),
          ),
          GetBuilder<ScreenController>(builder: (screen) {
            return Expanded(
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      Container(
                          margin: const EdgeInsets.all(3),
                          padding: const EdgeInsets.only(bottom: 10),
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(59, 35, 0, 80),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6))),
                          width: double.infinity,
                          child: Heatmap()),
                      ClickedCard(
                          const Icon(
                            Icons.sunny,
                            color: Color.fromARGB(255, 182, 164, 0),
                          ),
                          "Aujourd'hui",
                          0,
                          screen.selectedScreen,
                          screenConctroller,
                          context),
                      ClickedCard(
                          const Icon(
                            Icons.task_alt_outlined,
                            color: Colors.brown,
                          ),
                          "mes Tâches",
                          1,
                          screen.selectedScreen,
                          screenConctroller,
                          context),
                      ClickedCard(
                          const Icon(
                            Icons.star_border_outlined,
                            color: Colors.red,
                          ),
                          "Imporant",
                          2,
                          screen.selectedScreen,
                          screenConctroller,
                          context),
                      ClickedCard(
                          const Icon(
                            Icons.home_repair_service_outlined,
                            color: Colors.blue,
                          ),
                          "Affecté à moi ",
                          3,
                          screen.selectedScreen,
                          screenConctroller,
                          context),
                      ClickedCard(
                          const Icon(
                            Icons.category_rounded,
                            color: Colors.purple,
                          ),
                          "Categories ",
                          4,
                          screen.selectedScreen,
                          screenConctroller,
                          context),
                      ClickedCard(
                          const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          "bin ",
                          5,
                          screen.selectedScreen,
                          screenConctroller,
                          context),
                      Container(
                          decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: Color.fromARGB(33, 145, 145, 145),
                                width: 3)),
                      )),

                      // TODO: Insert data
                      Expanded(
                        child: ListView.builder(
                            itemCount: 6,
                            itemBuilder: (BuildContext context, int index) {
                              return ClickedCard(
                                  const Icon(
                                    Icons.list,
                                    color: Colors.grey,
                                  ),
                                  "  list  number ${index} ",
                                  index + 5,
                                  screen.selectedScreen,
                                  screenConctroller,
                                  context);
                            }),
                      ),
                    ],
                  )),
            );
          }),
        ],
      ),
    );
  }
}

Widget ClickedCard(Icon icon, String text, int index, int selectedScreen,
        ScreenController screenConctroller, context) =>
    Container(
      margin: const EdgeInsets.only(top: 2),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          switch (index) {
            case 4:
              screenConctroller.SelectScreen(index);
              Navigator.pop(context);
              Get.back();

              Get.to(Category_screen());
             break;
            default :
               screenConctroller.SelectScreen(index);
               Navigator.pop(context);
               Get.back();
               Get.to( ListScreen() ) ;
             break  ;


              Get.to(() => Category_screen());
              break;
<<<<<<< HEAD
            default:
              screenConctroller.SelectScreen(index);
              Navigator.pop(context);
              Get.back();
              Get.to(() => const ListScreen());
              break;
=======


>>>>>>> backendbranch
          }


        },
        style: elevatedbuttonStyle(index == selectedScreen),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
          child: Row(
            children: [
              icon,
              const SizedBox(
                width: 15,
              ),
              Text(
                text,
<<<<<<< HEAD
                style: const TextStyle(color: LightGrey, fontSize: 16),
=======
                style:const TextStyle(color: LightGrey, fontSize: 16),
>>>>>>> backendbranch
              ),
            ],
          ),
        ),
      ),
    );

Widget Rownedimage(String url) => Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(300))),
      child: Image.asset(
        url,
        width: 50,
        height: 50,
      ),
    );

elevatedbuttonStyle(isSelected) => ElevatedButton.styleFrom(
      foregroundColor: Colors.black87,
      backgroundColor:
          isSelected ? const Color.fromARGB(66, 167, 167, 167) : Colors.white,
      alignment: Alignment.centerLeft,
      elevation: 0,
      padding: EdgeInsets.zero,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );

Map<DateTime, int> heatMapDatasets = {
  DateTime.now().subtract(const Duration(days: 4)): 1,
  DateTime.now().subtract(const Duration(days: 5)): 3,
};

Widget Heatmap() => HeatMap(
      scrollable: false,
      fontSize: 10,
      size: 17,
      showColorTip: false,
      showText: false,
      endDate: DateTime.now(),
      startDate: DateTime.now().subtract(const Duration(days: 90)),
      colorMode: ColorMode.opacity,
      datasets: heatMapDatasets,
      colorsets: const {
        0: Colors.blue,
      },
      onClick: (value) {},
    );

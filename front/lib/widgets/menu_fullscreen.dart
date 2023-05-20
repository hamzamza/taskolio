import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:front/Models/list.dart';
import 'package:front/Models/project.dart';
import 'package:front/controllers/ProjectController.dart';
import 'package:front/controllers/screens_controller.dart';
import 'package:front/helpers/colors.dart';
import 'package:front/screens/TodayScreen.dart';
import 'package:front/screens/category_screen.dart';
import 'package:front/screens/list_screen.dart';
import 'package:front/widgets/CreateCategory.dart';
import 'package:get/get.dart';

import '../controllers/Listcontroller.dart';
import '../screens/ListTask.dart';

class MenuFullScreen extends StatelessWidget {
  ScreenController screenConctroller = Get.put(ScreenController());
  ListController listController=Get.put(ListController());
  ProjectController projectController=Get.put(ProjectController());
  MenuFullScreen({super.key});
  late int productivity = 6;
  @override
  Widget build(BuildContext context) {
    listController.fetchList();
    projectController.fetchProject();
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
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Hamza Douaij",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -0.5)),
                          SizedBox(
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
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
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
                        /*Expanded(
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
                        ),*/
                        Container(
                         // height: MediaQuery.of(context).size.height*1,
                          child: ExpansionPanelList.radio(
                            elevation: 0,
                             children: [
                                ExpansionPanelRadio(
                                    value: 0,
                                    headerBuilder:(context, isOpen) => ListViewHeader(context),
                                    body: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: ListViewBody(listController)
                                    )
                                )
                             ],
                          ),
                        ),
                        Container(
                          // height: MediaQuery.of(context).size.height*1,
                          child: ExpansionPanelList.radio(
                            elevation: 0,
                            children: [
                              ExpansionPanelRadio(
                                  value: 0,
                                  headerBuilder:(context, isOpen) => ProjectViewHeader(context),
                                  body: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: ProjectViewBody(projectController))
                                  )
                                 ],
                              )

                          ),

                      ],
                    ),
                  )),
            );
          }),
        ],
      ),
    );
  }
}
Widget ProjectViewHeader(BuildContext context){

  return Container(
    //height: 50,
    child: Row(
        children: [
          SizedBox(width: 10),
          Icon(
            Icons.qr_code,
            color: Colors.grey,
            size: 27,
          ),
          SizedBox(width: 5),
          Expanded(
            flex: 5,
            child: Text(
              "Project",
              style: TextStyle(
                  fontSize: 20 ,
                  fontWeight: FontWeight.w500
              ),
            ),
          ),
          Expanded(
              child: InkWell(
                onTap: (){
                  showModalBottomSheet(
                      isScrollControlled: false,
                      context: context,
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10.0),
                        ),
                      ),
                      builder: (builder){
                        return Container(
                            child: CreateCategory(createList: false,creatCategory: false,creatProject: true)
                        );
                      }
                  );
                },
                child: Icon(
                  Icons.add,
                ),
              )
          )
        ],
      ),

  );
}
Widget ProjectViewBody(ProjectController projectController){
   return Container(
      child: Obx(() => ListView.builder(
          shrinkWrap: true,
          itemCount: projectController.ProjectList.length,
          itemBuilder: (context,index)=> ListWidget(inList: false,inProject: true,project: projectController.ProjectList[index])
        ),
      )
  );
}
 Widget ListViewHeader(BuildContext context){
  return Container(
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(width: 10),
           Icon(
               Icons.list,
               color: Colors.grey,
               size: 27,
           ),
          SizedBox(width: 5),
           Expanded(
               flex: 5,
               child: Text(
                   "List",
                   style: TextStyle(
                      fontSize: 20 ,
                      fontWeight: FontWeight.w500
                   ),
               ),
           ),
           Expanded(
             flex: 1,
               child: InkWell(
                 onTap: (){
                   showModalBottomSheet(
                     isScrollControlled: false,
                     context: context,
                     backgroundColor: Colors.white,
                     shape: const RoundedRectangleBorder(
                       borderRadius: BorderRadius.vertical(
                         top: Radius.circular(10.0),
                       ),
                     ),
                     builder: (builder){
                        return Container(
                           child: CreateCategory(createList: true,creatCategory: false,)
                        );
                     }
                   );
                 },
                 child: Icon(
                   Icons.add,
                 ),
               )
           )
        ],
      ),

  );
}
Widget ListViewBody(ListController listController){
  return  Container(
    //margin: EdgeInsets.only(bottom: 10),
     child: Obx(() => ListView.builder(
            shrinkWrap: true,
            itemCount: listController.GroupList.length,
            itemBuilder: (context,index)=> ListWidget(taskList: listController.GroupList[index],listController: listController,inList: true, inProject: false)
           ),
       )
   );
 }
Widget ListWidget({TaskList? taskList, ListController? listController ,Project? project ,bool inList=false ,bool inProject=false}){
  if(inList){
    print(" list : ListWidget ${1}");
  }
  if(inProject){
    print(" project : projectWidget ${project!.title}");
    print("project section ${project.sections.length}");
  }

  var Listtitle =inList? taskList!.title.length! >10 ? taskList!.title.substring(1,10) + '...':taskList!.title:'' ;
  var ProjectTitle =inProject? project!.title.length! >10 ? project!.title.substring(1,10) + '...':project!.title:'' ;
  //print("new project title is ${ProjectTitle} with icon ${project!.icon}");
  return InkWell(
    onTap: (){
      if(inList){
        if(taskList!.id!=null){
          print("the list id iss: ${taskList!.id}");
          Get.toNamed('/list_task', arguments: taskList!.id);
        }
      } else if(inProject){
         Get.toNamed('/project_task', arguments: project!.id);
      }
    },
    child: Container(
      margin: inProject? EdgeInsets.only(bottom: 20): null,
       child: Row(
         children: [
           SizedBox(width: 20),
            Icon(
              Icons.circle,
              color: Colors.grey,
              size: 15,
            ),
           SizedBox(width: 15),
           Container(
             width: 150,
             child: Text(
               '${ inList? Listtitle: inProject ? ProjectTitle: ''} ${ inList? taskList!.icon!: inProject ? "": ''}' ,
               style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16
               ),
             ),
           ),

           SizedBox(width: 70),
           inList? showMenuListOption(listController!,taskList!.id):Container(),
           SizedBox(width: 20),
           Text(
             '${inList? taskList!.tasks!.length: inProject? project!.tasks.length:'' }'
           )
         ],
       ),
    ),
  );
}
Widget showMenuListOption(ListController listController,String taskListId){
  return PopupMenuButton(
     itemBuilder: (BuildContext context)=>[
        PopupMenuItem(
              child: TextButton.icon(
                  onPressed:(){
                     TaskList.deleteTaskList(taskListId);
                     listController.fetchList();
                  },
                  icon: Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                  ),
                  label: Text("Supprimer list")
              ),

        ),
       PopupMenuItem(
         child: TextButton.icon(
             onPressed:(){
             },
             icon: Icon(
               Icons.drive_file_rename_outline,
               color: Colors.grey,
             ),
             label: Text("Renomer list")
         ),

       )
     ],
  );
}
Widget ClickedCard(Icon icon, String text, int index, int selectedScreen,
        ScreenController screenConctroller, context) =>
    Container(
      margin: const EdgeInsets.only(top: 2),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          switch (index) {
            case 0:
              screenConctroller.SelectScreen(index);
              Navigator.pop(context);
              Get.to(Today());
              break;
            case 4:
              screenConctroller.SelectScreen(index);
              Navigator.pop(context);
              Get.back();
              Get.to(Category_screen());
             break;
            default :
               screenConctroller.SelectScreen(index);
               Navigator.pop(context);
               //Get.back();
               //Get.to( ListScreen() ) ;
             break  ;
               Get.to(() => Category_screen());
              break;
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
                style:const TextStyle(color: LightGrey, fontSize: 16),
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
          isSelected ? Color.fromARGB(66, 167, 167, 167) : Colors.white,
      alignment: Alignment.centerLeft,
      elevation: 0,
      padding: EdgeInsets.zero,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );

 Map<DateTime, int> heatMapDatasets = {
  DateTime.now().subtract(Duration(days: 4)): 1,
  DateTime.now().subtract(Duration(days: 5)): 3,
 };

 Widget Heatmap() => HeatMap(
      scrollable: false,
      fontSize: 10,
      size: 17,
      showColorTip: false,
      showText: false,
      endDate: DateTime.now(),
      startDate: DateTime.now().subtract(Duration(days: 90)),
      colorMode: ColorMode.opacity,
      datasets: heatMapDatasets,
      colorsets: const {
        0: Colors.blue,
      },
      onClick: (value) {},
    );

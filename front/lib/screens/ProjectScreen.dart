import 'package:flutter/material.dart';
import 'package:front/Models/project.dart';
import 'package:front/controllers/ProjectController.dart';
import 'package:front/controllers/TaskController.dart';
import 'package:front/widgets/TaskWidget.dart';
import 'package:get/get.dart';

import '../Models/task.dart';

class ProjectScreen extends StatelessWidget {
   ProjectScreen(){
      projectController.getProjectById(ProjectId);
   }
   ProjectController projectController=Get.put(ProjectController());
   final String ProjectId=Get.arguments!=null? Get.arguments : "";
   TextEditingController Sectioncontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //projectController.getProjectById(ProjectId);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Container(
             child: Row(
                children: [
                  Obx(() =>Text(
                       projectController.project.value.title,
                    ),
                  ),
                  SizedBox(width: 115),
                  Icon(
                    Icons.group
                  ),
                  SizedBox(width: 20),
                  PopupMenuButton(
                      itemBuilder: (BuildContext context)=>[
                        PopupMenuItem(
                          child: TextButton.icon(
                              onPressed:(){
                                showMyDialog(projectController);
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.grey,
                              ),
                              label: Text("Editer Projet")
                          ),
                        ),
                        PopupMenuItem(
                          child: TextButton.icon(
                              onPressed:(){
                              },
                              icon: Icon(
                                Icons.add,
                                color: Colors.red,
                              ),
                              label: Text("Ajouter tache")
                          ),
                        ),
                        PopupMenuItem(
                          child: TextButton.icon(
                              onPressed:(){
                              },
                              icon: Icon(
                                Icons.leave_bags_at_home,
                                color: Colors.grey,
                              ),
                              label: Text("Quiter Projet")
                          ),
                        ),
                      ]
                  )
                ],
             ),
          ),
        ),
        body: Container(
            child: Obx(() =>
                Container(
                  margin: EdgeInsets.only(top: 10),
                    height: MediaQuery.of(context).size.height,
                  child: /*ListView.builder(
                      shrinkWrap: false,
                      itemCount: projectController.project.value.sections.length!=null ?projectController.project.value.sections.length:0,
                      itemBuilder: (BuildContext context,int index) {
                        return SectionView(projectController.project.value!.sections[index]!,context);
                      }
                  ),*/
                    Column(
                      children: [
                        //Container(child: Text('section ${projectController.project.value.sections.length}'),)
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: projectController.project.value.sections.length!=null ?projectController.project.value.sections.length:0,
                          itemBuilder: (BuildContext context,int index) {
                          return SectionView(projectController.project.value!.sections[index]!,context);
                         }
                        ),
                      )
                      ],
                    )

                ),
            )
        ),
    );
  }
}
void showMyDialog(ProjectController projectController) {
  Get.dialog(
    AlertDialog(
      title: Text('My Dialog'),
      content: Container(
          margin: EdgeInsets.only(left: 10,top: 10),
          child:  Row(
            children: [
              TextField(
                onChanged: (value) {
                  projectController.SectionTitle.value=value;
                },
                //controller: taskTitleController,
                decoration: InputDecoration(
                    hintText: 'Section name',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,

                    )
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.send,
                  color: Colors.red,
                  size: 30,
                ),
                onPressed: (){
                  projectController.addSection(projectController.SectionTitle.value);
                },
              )
            ],
          )
      ),

    ),
  );
}

Widget SectionView(Section section,BuildContext context){
 TaskController taskController=Get.put(TaskController());
   return Container(
         width: 230,
         margin: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
         child: Expanded(
           child: ExpansionPanelList.radio(
                      children: [
                        ExpansionPanelRadio(
                            value: 0,
                            headerBuilder:(context, isOpen) =>SectionHeader(section),
                            body: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                child:Expanded(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: section!.tasks!.length!=null ?section!.tasks!.length:0,
                                      itemBuilder:(BuildContext context,int index){
                                         var task=section!.tasks![index] ;
                                         return ListCadrd(context, task , taskController);
                                         //return Text("task title is ${ section!.tasks![index].title}");
                                      }
                                   ),
                                ),

                               ),
                           )
                         ],

               ),
         ),



   );
}
 Widget SectionHeader(Section section){
   var SectionTitle=section.title.length >10 ? section.title.substring(0,10)+'...' :section.title;
    return Container(
     padding: EdgeInsets.only(left: 10),
     child: Row(
        children: [
            Container(
              width: 200,
              child: Text(
                '${SectionTitle}  ${section!.tasks!.length}',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(
              width: 50,
            ),
          showMenuListOption(section)
        ],
     ),
   );
}
Widget showMenuListOption(Section section){
  ProjectController projectController=Get.put(ProjectController());
  return PopupMenuButton(
    itemBuilder: (BuildContext context)=>[
      PopupMenuItem(
        child: TextButton.icon(
            onPressed:(

                ){
            },
            icon: Icon(
              Icons.add,
            ),
            label: Text("Ajouter tache")
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
            label: Text("Renomer Section")
        ),

      ),
      PopupMenuItem(
        child: TextButton.icon(
            onPressed:(){
            },
            icon: Icon(
              Icons.delete_forever,
              color: Colors.red,
            ),
            label: Text("Supprimer Section")
        ),

      ),
    ],
  );
}

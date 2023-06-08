import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front/Models/project.dart';
import 'package:front/api/Projet.dart';
import 'package:front/controllers/ProjectController.dart';
import 'package:front/controllers/TaskController.dart';
import 'package:front/widgets/TaskWidget.dart';
import 'package:get/get.dart';

import '../Models/task.dart';

class ProjectScreen extends StatelessWidget {
   ProjectScreen(){

   }
   ProjectController projectController=Get.put(ProjectController());
   final String ProjectId=Get.arguments!=null? Get.arguments : "";
   TextEditingController Sectioncontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //projectController.getProjectById(ProjectId);
    projectController.getProjectById(ProjectId);
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
                  InkWell(
                    onTap: (){
                      ShowDialogAddMemeber(context);
                    },
                    child: Icon(
                      Icons.group
                    ),
                  ),
                  SizedBox(width: 20),
                  PopupMenuButton(
                      itemBuilder: (BuildContext context)=>[
                        PopupMenuItem(
                          child: TextButton.icon(
                              onPressed:(){
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
                                showMyDialog(context,projectController);
                              },
                              icon: Icon(
                                Icons.edit_location_sharp,
                                color: Colors.grey,
                              ),
                              label: Text("Add Section")
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
                         ),

                      ],
                    )

                ),
            )
        ),
    );
  }
}

 void showMenuOptions(BuildContext context) async {
  ProjectController projectController=Get.put(ProjectController());
  final value = await showMenu(
    context: context,
    position: RelativeRect.fromLTRB(200, 350, 30, 0),    // Adjust the position as needed
    items: [
      PopupMenuItem<String>(
        value: 'Owner',
        child: TextButton.icon(
            onPressed: (){
              projectController.projectRole.value="owner";
            },
            icon: Icon(Icons.co_present),
            label: Text("Owner")
        ),
      ),
      PopupMenuItem<String>(
        value: 'Admin',
        child:TextButton.icon(
            onPressed: (){
              projectController.projectRole.value="admin";
            },
            icon: Icon(Icons.warehouse_rounded),
            label: Text("Admin")
        ),
      ),
      PopupMenuItem<String>(
        value: 'Member',
        child: TextButton.icon(
            onPressed: (){
              projectController.projectRole.value="member";
            },
            icon: Icon(Icons.supervised_user_circle_outlined),
            label: Text("member")
        ),
      ),
    ],
  );

}


void ShowDialogAddMemeber(BuildContext context){
  TextEditingController Emailcontroller = TextEditingController();
  TextEditingController Messagecontroller = TextEditingController();
  ProjectController projectController=Get.put(ProjectController());
  Get.dialog(
    AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 5),
      content: Container(
            width: MediaQuery.of(context).size.width,
            height: 350,
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          "Create a new user",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:FontWeight.w500,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                            border: Border.all(
                              color: Colors.black,  // Set the border color
                              width: 1.0,           // Set the border width
                            ),
                          ),
                          child: Icon(
                            Icons.close,
                            size: 25,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  child: Row(
                     children: [
                        Container(
                          width: 70,
                          child: Text(
                              " Email: ",
                                style: TextStyle(
                                   fontWeight: FontWeight.w600
                                ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                       Container(
                         width: 195,
                         height: 40 ,
                         child: Center(
                           child: TextField(
                             controller: Emailcontroller,
                             onChanged: (value) {
                             },
                             //controller: taskTitleController,
                             decoration:const InputDecoration(
                                 border: OutlineInputBorder(
                                   borderSide: BorderSide(
                                     color: Colors.grey,  // Set the border color
                                     width: 2.0,           // Set the border width
                                   ),
                                 ),
                                 hintText: 'membere name',
                                 //border: InputBorder.none,
                                 hintStyle: TextStyle(
                                   fontSize: 17,
                                   fontWeight: FontWeight.bold,
                                   color: Colors.grey,
                                 )
                             ),
                           ),
                         ),
                       ),

                     ],
                  ),
                ),
                SizedBox(height: 15,),
               /* Container(
                  child: Row(
                    children: [
                      TextButton.icon(
                          onPressed: (){}, icon: Icon(Icons.keyboard_option_key), label: Text("Role Options")),
                      ShowMenuOptions(),
                    ],
                  ),
                ),*/
                SizedBox(height: 15),
               Container(
                 child: Row(
                    children: [
                      Container(
                           width:70,
                          child: Text("Role")
                      ),
                      SizedBox(width: 5,),
                      Container(
                          width: 195,
                          height: 40 ,
                        child:  TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Select a Role',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,  // Set the border color
                                width: 2.0,           // Set the border width
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.arrow_drop_down),
                              onPressed: () {
                                showMenuOptions(context);
                              },
                            ),
                          ),
                          //controller: TextEditingController(text: _selectedOption),
                          readOnly: true,
                          onTap: () {
                            showMenuOptions(context);
                          },
                        ),
                      )
                    ],
                 ),
               ),
                SizedBox(height: 15,),
                Container(
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        child: Text(
                          " Message: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 195,
                        height: 100 ,
                        child: Center(
                          child: TextField(
                            controller: Messagecontroller,
                            onChanged: (value) {

                            },
                            //controller: taskTitleController,
                            decoration:const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,  // Set the border color
                                    width: 2.0,           // Set the border width
                                  ),
                                ),
                                hintText: 'membere name',
                                //border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                )
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                  child: ElevatedButton(
                    onPressed: ()async{
                        if(Emailcontroller.text.isEmpty || Messagecontroller.text.isEmpty){
                          Fluttertoast.showToast(
                              msg: "enter all the fileds",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey[600],
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }else{
                          String msg= await projectController.addMemberProject(Emailcontroller.text, projectController.projectRole.value, Messagecontroller.text);
                          EasyLoading.showSuccess(msg);
                          Navigator.of(context).pop();
                        }
                    },
                    child: Text(
                      "Add Member"
                    ),
                  )
                )
              ],
            ),

          ),// Your dialog content
    ),
  );
}

void showMyDialog(BuildContext context,ProjectController projectController) {
  Get.dialog(
    ClipRRect(
      child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        child: Container(
            width: 200,
            height: 70,
            margin: EdgeInsets.only(left: 10,top: 10),
            child:  Row(
              children: [
                Container(
                  width: 180,
                  child: TextField(
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
                ),
                SizedBox(width: 40),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Colors.red,
                    size: 30,
                  ),
                  onPressed: (){
                    projectController.addSection(projectController.SectionTitle.value);
                    Navigator.of(context).pop();
                    EasyLoading.showSuccess('Category ${projectController.SectionTitle.value} Created successfully!');
                  },
                )
              ],
            )
        ),
      ),
    )
  );
}

Widget SectionView(Section section,BuildContext context){
 TaskController taskController=Get.put(TaskController());
   return Container(
         //width: 230,
         margin: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
           child: ExpansionPanelList.radio(
                      children: [
                        ExpansionPanelRadio(
                            value: 0,
                            headerBuilder:(context, isOpen) =>SectionHeader(section),
                            body: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: section!.tasks!.length!=null ?section!.tasks!.length:0,
                                      itemBuilder:(BuildContext context,int index){
                                         var task=section!.tasks![index];
                                         return ListCadrd(context, task , taskController,index);
                                        // return Text("task title is ${ section!.tasks![index].title}");
                                       }
                                     ),

                                 ),
                               )
                         ],

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
                style:const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
             const SizedBox(
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
            onPressed:(){

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

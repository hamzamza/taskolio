

import 'package:front/Models/Category.dart';
import 'package:get/get.dart';

import '../api/catApi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyButton {
  final String title;
  final bool isSelected;

  MyButton({required this.title, this.isSelected = false});

  MyButton copyWith({String? title, bool? isSelected}) {
    return MyButton(
      title: title ?? this.title,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

class  categorieController extends GetxController {
  final buttons = [
    MyButton(title: 'Color'),
    MyButton(title: 'Photo'),
    MyButton(title: 'Custom'),
    MyButton(title: 'Emoji'),
  ].obs;
  var SelectedEmojis="".obs;
  var SelectedColor = Rx<Color?>(Colors.deepPurple[400]);
  var ColorsState=false.obs;
  var EmojisState=false.obs;
  var isViewVisible = false.obs;
  var showDialog=false.obs;
  var _selectedDate = DateTime.now().obs;
  var isHovered=false.obs;
  var ListCategories=<Category>[].obs;
  var deleting=false.obs;
  var screenState=true.obs;
  var CategoryTitleController = TextEditingController().obs;

  //var CatEditController = TextEditingController();
  changeDeleting(bool value){
    deleting.value=value;
  }
  fetchCategories()async{
    List<Category> categories = await Category.getAllCategories();
    ListCategories.value=categories;
  }


  void showMyDialog() {
    showDialog(true);
  }

  void hideMyDialog() {
    showDialog(false);
  }

  void setColorState(bool color){
    ColorsState.value=color;
    EmojisState.value=false;
  }

  void setEmojisState(bool emojis){
    EmojisState.value=emojis;
    ColorsState.value=false;
  }
  void setSelectedColor(Color color){
    SelectedColor.value=color;
  }

  void setSelectedEmoji(String emojis){
    SelectedEmojis.value=emojis;
  }

  void selectButton(MyButton button) {
    final index = buttons.indexOf(button);
    buttons.assignAll(
      buttons.map((btn) => btn.copyWith(isSelected: false)).toList(),
    );
    buttons[index] = button.copyWith(isSelected: true);
  }
  void showDialogWithInputs(BuildContext context) {
    Get.dialog(
      ClipRRect(
        child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              padding: EdgeInsets.only(bottom: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 200,
                    height: 40,
                    margin: EdgeInsets.only(left: 10,top: 10),
                    child: const TextField(
                      decoration: InputDecoration(
                          hintText: 'Task name',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,

                          )
                      ),
                    ),
                  ),
                  Container(
                    width: 250,
                    height: 25,
                    padding:const EdgeInsets.symmetric(horizontal: 10),
                    margin:const EdgeInsets.only(left: 10,top: 5),
                    child: const TextField(
                      decoration: InputDecoration(
                          hintText: 'Description',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          )
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          buildOption('Today', Icons.today,'0xff23850b',context,1.0),
                          buildOption('Priority', Icons.flag_outlined,'0xff173599',context,2.0),
                          buildOption('Rminder', Icons.alarm,'0xffbf841f',context,3.0),
                          buildOption('Categories', Icons.favorite,'0xff737272',context,4.0)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
  Widget buildOption(String title, IconData iconData,String colors,BuildContext context,double index) {
    final Color color=Color(int.parse(colors));
    return GestureDetector(
      onTap: () {
        // Handle option selection

        if( index == 1.0){
          _selectDate(context);
        }
        else{
          popupMenu(context,index);
        }
      },
      child: Container(
        width: 118,
        margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color:const Color(0xffb5b8b4),
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(iconData,color: color),
              const SizedBox(height: 8.0,width: 5,),
              Text(
                title,
                style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
  popupMenu(BuildContext context,double index)async {
    await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(50*index, 200.0, 50, 50),
        items: [
          PopupMenuItem(
              child: TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.flag,color: Colors.red,),
                label: Text('Priority 1'),
              )),
          PopupMenuItem(
              child: TextButton.icon(
                onPressed: () {},
                icon:const Icon(Icons.flag,color: Colors.yellow),
                label: Text('Priority 2'),
              )),
          PopupMenuItem(
              child: TextButton.icon(
                onPressed: () {
                },
                icon:const Icon(Icons.flag,color: Colors.blue),
                label: Text('Priority 3'),
              )),
          PopupMenuItem(
              child: TextButton.icon(
                onPressed: () {
                },
                icon: Icon(Icons.flag_outlined,color: Color(0xf0646664)),
                label: Text('Priority 4'),
              ))
        ]);
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate.value,
        firstDate: DateTime(2010),
        lastDate: DateTime(2050));
    if (picked != null && picked != _selectedDate) {
      _selectedDate.value = picked;
    }
  }
}










import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front/Models/category.dart';
import 'package:get/get.dart';

import '../controllers/categorie_controller.dart';
class CreateCategory extends StatefulWidget {
  const CreateCategory({Key? key}) : super(key: key);

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  categorieController controller=Get.put(categorieController());
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: kToolbarHeight,
            child: Row(
              children: [
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    'Create a new list',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                IconButton(
                  icon:const Icon(
                    Icons.close,
                    size: 35.0,
                  ),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          const Padding(
            padding:  EdgeInsets.only(left: 25.0),
            child: Text(
              'Title',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 1),
            child: Obx(()=>TextField(
              controller: controller.CategoryTitleController.value,
              decoration: InputDecoration(
                hintText: 'Enter List Title',
                border:const  UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red, // set the color here
                    width: 2.0,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: controller.SelectedColor.value!, width: 2.0),
                ),

                hintStyle:const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 25,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    //TODO: clear the text field
                  },
                ),
              ),
            ),)
          ),
            Padding(
            padding:const  EdgeInsets.only(left: 25.0,top:10),
            child: Obx(() => Text(
              'List properties',
              style: TextStyle(
                  color: controller.SelectedColor.value!,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
             ),
            )
          ),

          buildOptions(),
          //CirleList(context),
          // EmojisList()
          Obx(() => controller.ColorsState.value ? CirleList(context):Container()),
          Obx (() => controller.EmojisState.value ? EmojisList():Container()),
          Container(
            width: 400,
            child: Center(
              child: ElevatedButton(
                onPressed: (){
                     if(controller.SelectedEmojis.isEmpty || controller.CategoryTitleController.value.text.isEmpty){
                                Fluttertoast.showToast(
                                    msg: "enter all the fileds",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey[600],
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                     }
                     else{
                        var title=controller.CategoryTitleController.value.text;
                        var icon =controller.SelectedEmojis.value;
                        var them=controller.SelectedColor.value!;
                        Category newCategory=Category(title: title, them: them, icon: icon);
                        var isAdded= Category.addCategory(newCategory);
                        print("is addes $isAdded");
                     }

                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // rounded corner radius
                  ),
                ),
                child: Text('Create a Category'),
              ),
            ),
          )
        ],
      ),
    );;
  }
  Widget CirleList(BuildContext context){
    List<Color?> colors = [
      Colors.blue[300],
      Colors.blueGrey[300],
      Colors.red[400],
      Colors.indigo[400],
      Colors.deepPurple[400],
      Colors.lightBlue[400],
      Colors.lime[400],
      Colors.amber[400],
      Colors.grey[400],
      Colors.brown[400],
    ];

    return  SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: colors.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              controller.SelectedColor.value = colors[index];
            },
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: Material(
                      color: colors[index],
                      shape: CircleBorder(),
                      child: Obx(() {
                        return controller.SelectedColor.value == colors[index]
                            ? const Center(
                          child: SizedBox(
                            width: 8,
                            height: 8,
                            child: Material(
                              color: Colors.white,
                              shape: CircleBorder(),
                            ),
                          ),
                        )
                            : Container();
                      }),
                    ),
                  ),
                  Text(
                    _getColorName(colors[index]!),
                    style:const TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _getColorName(Color color) {
    if (color == Colors.red) return 'Red';
    if (color == Colors.orange) return 'Orange';
    if (color == Colors.yellow) return 'Yellow';
    if (color == Colors.green) return 'Green';
    if (color == Colors.blue) return 'Blue';
    if (color == Colors.indigo) return 'Indigo';
    if (color == Colors.purple) return 'Purple';
    return '';
  }

  Widget EmojisList(){
    final List<String> EmojiLList = [
      '📚' ,
      '📝',
      '💻',
      '🛠️',
      '🍴',
      '💪',
      '🚶‍♂️',
      '🛍️',
      '👪',
      '🧘',
      '🎨',
      '🎵',
      '📷',
      '🌺',
      '🌞',
      '🧹',
    ];
    return Container(
      height: 130,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding:const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            childAspectRatio: 1,
          ),
          itemCount: EmojiLList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap:(){
                controller.setSelectedEmoji(EmojiLList[index]);
                controller.setEmojisState(false);
              } ,
              child: Obx(
                    ()=>MouseRegion(
                  onEnter: (event) => controller.isHovered.value = true,
                  onExit: (event) =>  controller.isHovered.value = false,
                  child: Padding(
                    padding:const EdgeInsets.all(8.0),
                    child: Container(
                      color: controller.isHovered.value? Color(0xffc2c2c2):Colors.white,
                      child: Text(
                        EmojiLList[index],
                        style:const TextStyle(
                          fontSize: 26,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),

    );


  }


  Widget buildOptions() {
    return  Container(
      child: Obx(()=>Container(
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
        child: Wrap(
          spacing: 5,
          runSpacing: 5,
          children: controller.buttons.map((button) {
            var index=controller.buttons.indexOf(button);
            return Container(
              child: GestureDetector(
                  onTap: (){
                    switch(index){
                      case 0:
                        controller.setColorState(true);
                        break;
                      case  3:
                        controller.setEmojisState(true);
                        break;
                      default:
                        controller.setColorState(false);
                        controller.setEmojisState(false);
                    }
                    controller.selectButton(button);
                  },
                  child: Container(
                    padding:const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                    decoration:  BoxDecoration(
                        border:  Border.all(
                          color: controller.SelectedColor.value!,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        color: button.isSelected ? controller.SelectedColor.value : Colors.white
                    ),
                    child:Text(
                      button.title,
                      style: TextStyle(
                          color: button.isSelected ? Colors.white : controller.SelectedColor.value,
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                    ) ,
                  )

              ),
            );
          }).toList(),
        ),
      )
      ),
    );
  }

}



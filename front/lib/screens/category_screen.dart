
import 'package:dotted_border/dotted_border.dart';
import 'package:front/controllers/categorie_controller.dart';
import 'package:front/main.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../widgets/menu_bottom.dart';

class Category_screen extends StatelessWidget {
   Category_screen({Key? key}) : super(key: key) {
     controller.fetchCategories();
   }
   categorieController controller=Get.put(categorieController());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
         //appBar:buildAppBar(),
         appBar: AppBar(
            title: Container(
              child: const Text(
                'Cateogories',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.2,
                    fontSize: 25.0,
                    fontFamily: 'Heebo-Bold'),
              ),
            ),
           elevation: 0,
           toolbarHeight: 50.0,
           backgroundColor: Colors.white,
         ),
         body: Container(
           height:  MediaQuery.of(context).size.height,
           padding: EdgeInsets.only(top: 20.0, left: 5),
           child: ListView(
             children: [
               Container(
                 padding: EdgeInsets.only(left: 10),
                 child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       /*const Text(
                         'Hello, Oussama !',
                         style: TextStyle(
                             fontWeight: FontWeight.w900,
                             letterSpacing: 0.2,
                             fontSize: 30.0,
                             fontFamily: 'Heebo-Bold'),
                       ),*/
                       searchBox(),

                     ]),
               ),
               Obx(() => buildGridCategorie(context)) ,
               //Menubottom()
             ],
           ),
         ),
      bottomNavigationBar: Container(height: 70, child:   Menubottom()),
    );
  }

  Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
              isScrollControlled: false,
              context: context,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10.0),
                ),
              ),
              builder: (builder) {
                return  Container(
                  height: MediaQuery.of(context).size.height* 0.95,
                  child: Column(
                    children: [
                      // here you can put the child here
                      CategorieCont(context)
                    ],
                  ),
                );
              },
            );
  }
   /* ------------------------------------- Grid Category --------------------------------------------------- */

   Widget CategorieCont(BuildContext context) {

     return Container(
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
             child: TextField(
               decoration: InputDecoration(
                 hintText: 'Enter List Title',
                 border: OutlineInputBorder(
                   borderSide:const BorderSide(color: Colors.grey, width: 5.0),
                   borderRadius: BorderRadius.circular(10.0),
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
             ),
           ),
           const Padding(
             padding:  EdgeInsets.only(left: 25.0,top:10),
             child: Text(
               'List properties',
               style: TextStyle(
                   fontSize: 20,
                   fontWeight: FontWeight.bold
               ),
             ),
           ),

           buildOptions(),
           //CirleList(context),
           // EmojisList()
           Obx(() => controller.ColorsState.value ? CirleList(context):Container()),
           Obx(() => controller.EmojisState.value ? EmojisList():Container())
         ],
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

   Widget   buildGridCategorie(BuildContext context) {

     return  Container(
       height: MediaQuery.of(context).size.height*0.7, // Set the height as needed
       child: GridView.builder(
           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
               crossAxisCount: 2,
               crossAxisSpacing: 2,
               childAspectRatio: 1.02,
               mainAxisSpacing: 2
           ),
           itemCount:  controller.ListCategories.length + 1,
           itemBuilder: (context, index) => index < controller.ListCategories.length
               ? LongPressDraggable(
             onDragStarted: () =>controller.changeDeleting(true),
             onDraggableCanceled: (_, __) => controller.changeDeleting(false),
             onDragEnd: (_) => controller.changeDeleting(false),
             feedback: Opacity(
               opacity: 1,
               child: CeategorieDrag(
                 controller.ListCategories[index].title,
                 Color(0x568cf0),
                 Icons.person,
               ),
             ),
             child: Ceategorie(controller.ListCategories[index].title, Color(0xFF568cf0),
                 Icons.person, 2, 2, controller.ListCategories[index].id!, context),
             childWhenDragging: Ceategorie(
                 controller.ListCategories[index].title,
                 Color(0xFF568cf0),
                 Icons.person,
                 2,
                 2,
                 controller.ListCategories[index].id!,
                 context),
           )
               : dottedBorder(context)),
     );
   }
   AppBar buildAppBar() {
     return AppBar(
       backgroundColor: Colors.transparent,
       elevation: 0,
       toolbarHeight: 60.0,
       leading: Builder(
         builder: (context) => IconButton(
           icon:const Icon(
             Icons.menu,
             color: Colors.black,
             size: 32,
           ),
           onPressed: () {

           },
         ),
       ),
       title: Align(
         alignment: Alignment.topRight,
         child: Container(
           width: 50.0,
           height: 60.0,
           margin: EdgeInsets.only(top: 10.0),
           decoration: BoxDecoration(
             border: Border.all(color: Colors.grey, width: 2.0),
             shape: BoxShape.circle,
             image:const DecorationImage(
               image: AssetImage('assets/images/user_image.jpeg'),
             ),
           ),
         ),
       ),
     );
   }
   /* ------------------------------------- CategorieWidget--------------------------------------------------- */

   Widget CeategorieDrag( String? title, Color? color, IconData? icon){
     return Container(
       width: 110,
       height: 130,
       padding: EdgeInsets.all(10),
       decoration: BoxDecoration(
         //color: color!.withOpacity(0.3),
           gradient: LinearGradient(
               begin: Alignment.bottomCenter,
               end: Alignment.topCenter,
               colors: [
                 color!.withOpacity(1.0),
                 color!.withOpacity(0.5),
               ]
           ),
           boxShadow: [
             BoxShadow(
               color: Colors.grey.withOpacity(0.4),
               spreadRadius: 1,
               blurRadius: 5,
               offset: Offset(0, 3), // changes position of shadow
             ),
           ],
           borderRadius: BorderRadius.circular(20)
       ),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Container(
             width: 30.0,
             height: 30.0,
             child: Icon(
               icon,
               color: color!.withOpacity(1),
               size: 30,
             ),
           ),
           Container(
             margin: EdgeInsets.only(top: 20.0, bottom: 15.0),
             child: Text(
               title!,
               style: const TextStyle(
                   fontSize: 14.0,
                   fontFamily: 'Heebo-Bold'),
             ),
           ),
           Container(
             child:const Text(
               '10 Tasks',
               style: const TextStyle(
                   fontSize: 12.0,
                   fontFamily: 'Heebo-Bold'),
             ),
           ),

         ],
       ),

     );
   }
/* ------------------------------------- Categorie--------------------------------------------------- */
   Widget Ceategorie(String? title, Color? color, IconData? icon, int? left,
       int? done, String categoryId, BuildContext context) {
     return GestureDetector(
       onTap: () {

       },
       child: Container(
         margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
         decoration: BoxDecoration(
           //color: color!.withOpacity(0.3),
             gradient: LinearGradient(
                 begin: Alignment.bottomCenter,
                 end: Alignment.topCenter,
                 colors: [
                   color!.withOpacity(1.0),
                   color!.withOpacity(0.5),
                 ]

             ),
             boxShadow: [
               BoxShadow(
                 color: Colors.grey.withOpacity(0.4),
                 spreadRadius: 1,
                 blurRadius: 5,
                 offset: Offset(0, 3), // changes position of shadow
               ),
             ],
             borderRadius: BorderRadius.circular(20)
         ),
         padding: EdgeInsets.only(top: 10.0, left: 10.0, bottom: 15),
         child: Expanded(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Container(
                 width: 40.0,
                 height: 40.0,
                 child: Icon(
                   icon,
                   color: color!.withOpacity(1),
                   size: 50,
                 ),
               ),
               Container(
                 margin: EdgeInsets.only(top: 20.0, bottom: 15.0),
                 child: Text(
                   title!,
                   style: const TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 20.0,
                       fontFamily: 'Heebo-Bold'),
                 ),
               ),
               Container(
                 child:const Text(
                   '10 Tasks',
                   style: const TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 18.0,
                       fontFamily: 'Heebo-Bold'),
                 ),
               ),

             ],
           ),
         ),
       ),
     );
   }

  /* ------------------------------------- dotted Border --------------------------------------------------- */
  Widget dottedBorder(BuildContext context) {
    return InkWell(
      onTap: () {
          buildShowModalBottomSheet(context);
      },
      child: Container(
        width: 120,
        height: 100,
        margin:const EdgeInsets.only(right: 10, top: 12, bottom: 10, left: 5),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(20),
          dashPattern: [15, 15],
          color: Colors.grey,
          strokeWidth: 3.0,
          child: const Center(
            child: Text(
              "+ add",
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }



/* ------------------------------------- serchBox --------------------------------------------------- */
  Row searchBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 3),
          margin: EdgeInsets.only(top: 15.0),
          width: 250.0,
          decoration: BoxDecoration(
            color: Color(0xE1d9ebfa),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: const TextField(
            //onChanged: (value)=>searchToDoItems(value),
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(fontSize: 19.0, fontWeight: FontWeight.w400),
              suffixIcon: Icon(
                Icons.search_sharp,
                color: Colors.black,
                size: 25.0,
              ),
              prefixIconConstraints: BoxConstraints(),
              border: InputBorder.none,
            ),
          ),
        ),
        /*Container(
          margin: EdgeInsets.only(right: 20.0),
          child: IconButton(
            onPressed: (){
              Get.snackbar(
                  'Snack Bar',
                  'Message Bar',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.red,
                  isDismissible: true,
                  dismissDirection: DismissDirection.horizontal,
                  forwardAnimationCurve: Curves.bounceInOut,
                  duration: Duration(seconds: 5)

              );
            },
            icon:const Icon(
              Icons.sort,
              size: 34.0,

            ),
          ),
        )*/
      ],
    );
  }
}
/* ------------------------------------- app bar --------------------------------------------------- */


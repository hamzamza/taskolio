import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/categorie_controller.dart';
import 'CreateCategory.dart';

class GridCategory extends StatelessWidget {
   GridCategory(  ) ;
   categorieController controller=Get.put(categorieController());
   String? title ;
   Color? color;
   IconData? icon;
  @override
  Widget build(BuildContext context) {
    return
      Container(
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
                child: CategoryBody(controller.ListCategories[index].title!,Color(0xff387ff2),Icons.person),
              ),
              child: CategoryBody(controller.ListCategories[index].title!,Color(0xff387ff2),Icons.person),
              childWhenDragging:CategoryBody(controller.ListCategories[index].title!,Color(0xff387ff2),Icons.person) ,
            )
                : dottedBorder(context)),
      );
      ;
  }
  Widget CategoryBody(String title,Color color,IconData icon){
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
               CreateCategory()
             ],
           ),
         );
       },
     );
   }
}

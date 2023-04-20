
import 'package:dotted_border/dotted_border.dart';
import 'package:front/controllers/categorie_controller.dart';
import 'package:front/main.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../widgets/GridCategory.dart';
import '../widgets/CreateCategory.dart';
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
               GridCategory()
               //Menubottom()
             ],
           ),
         ),
      bottomNavigationBar: Container(height: 70, child:   Menubottom()),
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
      ],
    );
  }
}
/* ------------------------------------- app bar --------------------------------------------------- */


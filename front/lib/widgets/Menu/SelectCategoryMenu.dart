import 'package:flutter/material.dart';
import 'package:front/controllers/Listcontroller.dart';

import '../../Models/category.dart';
import '../../controllers/TaskController.dart';


void selectCategoryMenu(BuildContext context,TaskController taskController)async{
  await taskController.getAllCategories();
  var categories=taskController.allCategories.value;
  showMenu(
      context: context,
      position:RelativeRect.fromLTRB(200, 300.0, 200, 50),
      items: categories.map((category) =>
          PopupMenuItem(
            onTap: (){
              taskController.categoryId.value=category.id;
              taskController.getCategory(category.id);
            },
            child: TextButton(
              onPressed: (){
                /*taskController.categoryId.value=category.id;
                taskController.getCategory(category.id);*/
              },
              child: Row(
                  children: [
                  Text(category.icon!),
              SizedBox(width: 15,),
              Text(category.title),
              ],
            ),
          )
      )
  ).toList(),

  );
}


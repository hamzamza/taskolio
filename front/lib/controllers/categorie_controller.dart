import 'package:front/Models/category.dart';
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

class categorieController extends GetxController {
  final buttons = [
    MyButton(title: 'Color'),
    MyButton(title: 'Photo'),
    MyButton(title: 'Custom'),
    MyButton(title: 'Emoji'),
  ].obs;
  var SelectedEmojis = "".obs;
  var SelectedColor = Rx<Color?>(Colors.deepPurple[400]);
  var ColorsState = false.obs;
  var EmojisState = false.obs;
  var isViewVisible = false.obs;
  var showDialog = false.obs;
  var isHovered = false.obs;
  var ListCategories = <Category>[].obs;
  var deleting = false.obs;
  var screenState = true.obs;
  var CategoryTitleController = TextEditingController().obs;
  var myCategory = Category(title: "", them: Colors.white, icon: "").obs;
  //var CatEditController = TextEditingController();
  changeDeleting(bool value) {
    deleting.value = value;
  }

  fetchCategories() async {
    print("hello to fetchCategorieeeeeeeee ");
    List<Category> categories = await Category.getAllCategories();
    ListCategories.value = categories;
  }

  getCategoryById(String id) async {
    var category = await Category.getCategoryById(id);
    myCategory.value = category!;
  }

  void showMyDialog() {
    showDialog(true);
  }

  void hideMyDialog() {
    showDialog(false);
  }

  void setColorState(bool color) {
    ColorsState.value = color;
    EmojisState.value = false;
  }

  void setEmojisState(bool emojis) {
    EmojisState.value = emojis;
    ColorsState.value = false;
  }

  void setSelectedColor(Color color) {
    SelectedColor.value = color;
  }

  void setSelectedEmoji(String emojis) {
    SelectedEmojis.value = emojis;
  }

  void selectButton(MyButton button) {
    final index = buttons.indexOf(button);
    buttons.assignAll(
      buttons.map((btn) => btn.copyWith(isSelected: false)).toList(),
    );
    buttons[index] = button.copyWith(isSelected: true);
  }
}
// ---------------------------------

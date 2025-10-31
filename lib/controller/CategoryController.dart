import 'dart:convert';

import 'package:finly/data/CategoryList.dart';
import 'package:finly/prefs/CategoryPrefs.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Category.dart';

class CategoryController extends GetxController {
  CategoryPrefs categoryPrefs = CategoryPrefs();

  // var categoryList = CategoryList().categories.obs;
  var categoryList = <Category>[].obs;

  DateTime? selectedDate;
  var isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await categoryPrefs.loadCategory(this);
  }

  Future<void> addCategory(Category category) async {
    categoryList.add(category);
    categoryPrefs.saveCategory(categoryList);
  }

  Future<void> updateCategory(Category category) async {
    var index = categoryList.indexWhere((item) => category.id == item.id);
    if (index < 0) return;
    categoryList.insert(index, category);
    categoryPrefs.saveCategory(categoryList);
  }
}

import 'dart:convert';

import 'package:finly/controller/CategoryController.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Category.dart';

class CategoryPrefs{
  var categoryKey = 'categoryKey';

  Future<void> saveCategory(List<Category> category) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final categoryMaps = category.map((cat) => cat.toJson()).toList();
    await prefs.setString(categoryKey, jsonEncode(categoryMaps));
  }

  Future<void> loadCategory(CategoryController categoryController) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(categoryKey);
    if (jsonString != null) {
      categoryController.categoryList.value = (jsonDecode(jsonString) as List)
          .map((cat) => Category.fromJson(cat))
          .toList();
    }
  }
}
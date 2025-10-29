import 'dart:convert';

import 'package:finly/data/CategoryList.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Category.dart';

class CategoryController extends GetxController {
  var categoryList = CategoryList().categories.obs;
  var categoryKey = 'categoryKey';

  DateTime? selectedDate;
  var isLoading = false.obs;

  @override
  void onInit() {
    loadCategory();
  }

  Future<void> saveCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Convert List<Category> to List<Map<String, dynamic>>
    List categoryMaps =
        await categoryList.map((cat) => categoryList.toJson()).toList();
    final String jsonString = jsonEncode(categoryMaps);
    await prefs.setString(categoryKey, jsonString);
  }

  Future<void> loadCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(categoryKey);
    if (jsonString != null) {
      //decode the json string that is saved
      final List<dynamic> categoryMap = jsonDecode(jsonString);
      // Convert List<dynamic> to List<Category>
      categoryList.value = categoryMap
          .map((cat) => Category.fromJson(cat as Map<String, dynamic>))
          .toList()
          .obs;
    }
  }

  Future<void> addCategory(Category category) async {
    categoryList.value.add(category);
    saveCategory();
  }

  Future<void> updateCategory(int index) async{
    //TODO : update function
  }
}

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
    List<String> categoryMaps = categoryList.value.map((cat) => jsonEncode(cat.toJson())).toList();
    // final String jsonString = jsonEncode(categoryMaps);
    await prefs.setStringList(categoryKey, categoryMaps);
  }

  Future<void> loadCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getStringList(categoryKey);
    if (jsonString != null) {
      //decode the json string that is saved
      // final String categoryMap = jsonDecode(jsonString);
      // Convert List<dynamic> to List<Category>
      categoryList.value = jsonString
          .map((cat) => Category.fromJson(jsonDecode(cat)))
          .toList()
          .obs;
    }
  }

  Future<void> addCategory(Category category) async {
    categoryList.value.add(category);
    saveCategory();
  }

  Future<void> updateCategory(Category category) async{
    var index = categoryList.value.indexWhere((item) => category.id == item.id);
    if(index < 0) return;
    categoryList.value.insert(index, category);
    saveCategory();
  }
}

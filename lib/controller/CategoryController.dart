import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Category.dart';

class CategoryController extends GetxController{
  var categoryList = <Category>[].obs;
  var categoryKey = 'categoryKey';

  DateTime? selectedDate;
  var isLoading = false.obs;
  var budgetAmount = 0.0.obs;
  var totalAmount = 0.0.obs;

  Future<void> loadTotalAmount() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    totalAmount.value = sharedPreferences.getDouble('totalAmount') ?? 0.0;
    budgetAmount.value = sharedPreferences.getDouble('budget') ?? 0.0;
  }

  @override
  void onInit() {
    loadCategory();
  }

  Future<void> saveCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Convert List<Category> to List<Map<String, dynamic>>
    List categoryMaps = categoryList.map((cat) => categoryList.toJson()).toList();
    final String jsonString = jsonEncode(categoryMaps);
    await prefs.setString(categoryKey, jsonString);
  }

  Future<void> loadCategory() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jsonString = await prefs.getString(categoryKey);
    if(jsonString != null){
      //decode the json string that is saved
      final List<dynamic> categoryMap = jsonDecode(jsonString);
      // Convert List<dynamic> to List<Category>
      categoryList.value = categoryMap.map((cat) => Category.fromJson(cat as Map<String, dynamic>)).toList();
      prefs.getDouble('totalAmount');
      prefs.getDouble('budget');
    }
  }

  Future<void> addCategory(Category category)async{
    categoryList.add(category);
    saveCategory();
  }
}
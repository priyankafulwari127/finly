import 'package:finly/localStorage/CategoryHive.dart';
import 'package:get/get.dart';

import '../model/categoryModel/Category.dart';

class CategoryController extends GetxController {
  CategoryHive categoryHive = CategoryHive();

  var categoryList = <Category>[].obs;

  DateTime? selectedDate;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    categoryList.value = categoryHive.getAllCategories();
  }

  Future<void> addCategory(Category category) async {
    categoryList.add(category);
    categoryHive.addCategory(category);
  }

  Future<void> updateCategory(Category category) async {
    var index = categoryList.indexWhere((item) => category.id == item.id);
    if (index < 0) return;
    categoryList.insert(index, category);
    categoryHive.updateCategory(index, category);
    // categoryHive.addCategory(category);
  }
}

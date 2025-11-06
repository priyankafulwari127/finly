import 'package:finly/localStorage/hiveDatabase.dart';
import 'package:get/get.dart';

import '../model/Category.dart';

class CategoryController extends GetxController {
  HiveDatabase hiveDatabase = HiveDatabase();

  var categoryList = <Category>[].obs;

  DateTime? selectedDate;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    categoryList.value = hiveDatabase.getAllCategories();
  }

  Future<void> addCategory(Category category) async {
    categoryList.add(category);
    hiveDatabase.addCategory(categoryList);
  }

  Future<void> updateCategory(Category category) async {
    var index = categoryList.indexWhere((item) => category.id == item.id);
    if (index < 0) return;
    categoryList.insert(index, category);
    hiveDatabase.addCategory(categoryList);
  }
}

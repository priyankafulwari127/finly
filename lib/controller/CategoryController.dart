import 'package:finly/localStorage/CategoryHive.dart';
import 'package:finly/localStorage/TransactionHive.dart';
import 'package:get/get.dart';

import '../model/categoryModel/Category.dart';

class CategoryController extends GetxController {
  CategoryHive categoryHive = CategoryHive();
  TransactionHive transactionHive = TransactionHive();

  var categoryList = <Category>[].obs;

  DateTime? selectedDate;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    categoryList.value = categoryHive.getAllCategories().map((c)=>
        getCategoryWithTotal(c)
    ).toList();
  }

  Category getCategoryById(String categoryId) {
    return categoryHive.getCategoryById(categoryId);
  }

  Category getCategoryWithTotal(Category c) {
    c.totalAmount = transactionHive.getTotalByCategory(c.id!);
    return c;
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

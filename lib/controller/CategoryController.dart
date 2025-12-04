import 'package:finly/controller/TransactionController.dart';
import 'package:finly/localStorage/CategoryHive.dart';
import 'package:finly/localStorage/TransactionHive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../model/categoryModel/Category.dart';

class CategoryController extends GetxController {
  CategoryHive categoryHive = CategoryHive();
  TransactionHive transactionHive = TransactionHive();
  TextEditingController dateController = Get.put(TextEditingController());

  TransactionController transactionController = Get.put(TransactionController());
  var categoryList = <Category>[].obs;
  var selectedDate = Rxn<DateTime>();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    categoryList.value = categoryHive
        .getAllCategories()
        .map(
          (c) => getCategoryWithTotal(c),
        )
        .toList();
  }

  Category getCategoryById(String categoryId) {
    return categoryHive.getCategoryById(categoryId);
  }

  Category getCategoryWithTotal(Category c) {
    c.totalAmount = transactionController.getTotalByCategory(c.id);
    return c;
  }

  Future<void> addCategory(Category category) async {
    categoryList.add(category);
    await categoryHive.addCategory(category);
  }

  Future<void> updateCategory(Category category) async {
    var index = categoryList.indexWhere((item) => category.id == item.id);
    if (index < 0) return;
    categoryList.insert(index, category);
    await categoryHive.updateCategory(index, category);
  }

  Future<void> removeCategory(int index) async {
    categoryList.removeAt(index);
    await categoryHive.removeCategory(index);
  }

  Future<void> selectDate(BuildContext context, Category category) async {
    final DateTime? picked = await showDatePicker(
      initialDate: selectedDate.value ?? DateTime.now(),
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      final formattedDate = DateFormat("dd-MM-yyyy").format(picked);
      dateController.text = formattedDate;
      selectedDate.value = picked;
      var categoryDate = categoryList.firstWhereOrNull((cat) => cat.id == category.id);
      categoryDate?.date = picked.toString();
    }
  }

  @override
  void onClose() {
    dateController.dispose();
    super.onClose();
  }
}

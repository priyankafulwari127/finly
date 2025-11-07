import 'package:finly/model/Category.dart';
import 'package:finly/ui/TransactionHistory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controller/CategoryController.dart';

class DetailsScreen extends StatelessWidget {
  final String categoryName;
  final String id;

  DetailsScreen({super.key, required this.categoryName, required this.id});

  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController budgetController = TextEditingController();

  CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    var category = categoryController.categoryList.firstWhereOrNull((cat) => cat.id == id);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: categoryController.isLoading.value
          ? CircularProgressIndicator()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Text(
                      'Your total outstanding amount',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[550],
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "${category?.totalAmount}",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Amount',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    onChanged: (value) async {
                      // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                      var amount = double.tryParse(value);
                      category?.spentAmount = amount;
                      double budget = category?.budgetAmount ?? 0.0;
                      if (amount! >= budget) {
                        Get.snackbar(
                          'Error',
                          'Your amount is higher than your monthly budget',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }
                    },
                    controller: amountController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            12,
                          ),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            12,
                          ),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Enter spent amount',
                      fillColor: Colors.grey[300],
                      filled: true,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Description',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            12,
                          ),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            12,
                          ),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Enter Description',
                      fillColor: Colors.grey[300],
                      filled: true,
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Date',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    onTap: () {
                      _selectDate(context);
                    },
                    controller: dateController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            12,
                          ),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            12,
                          ),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.calendar_month),
                      hintText: 'DD-MM-YYYY',
                      fillColor: Colors.grey[300],
                      filled: true,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Set Budget',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: budgetController,
                    onChanged: (value) async {
                      double budget = double.tryParse(value) ?? 0.0;
                      category?.budgetAmount = budget;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            12,
                          ),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            12,
                          ),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      hintText: category?.budgetAmount != 0 ? category?.budgetAmount.toString() : 'Enter monthly budget',
                      fillColor: Colors.grey[300],
                      filled: true,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.height,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              12,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        double spentAmount = double.tryParse(amountController.text) ?? 0.0;
                        Get.to(
                          TransactionHistory(
                            id: id,
                            spentAmount: spentAmount,
                            description: descriptionController.text,
                            date: dateController.text,
                          ),
                        );
                      },
                      child: Text(
                        'Transaction History',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.height,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              12,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        double enteredAmount = double.tryParse(amountController.text) ?? 0.0;
                        var budget = category?.budgetAmount ?? 0.0;
                        if (category!.spentAmount! == 0) {
                          Get.snackbar('Error', 'Please enter amount');
                        } else if (dateController.text.isEmpty) {
                          Get.snackbar('Error', 'Please select date');
                        } else if (category.budgetAmount == 0) {
                          Get.snackbar('Error', 'Please enter budget');
                        } else if (enteredAmount >= budget) {
                          Get.snackbar('Error', 'Spent amount is greater than budget');
                        } else {
                          var newCategory = category;
                          newCategory.totalAmount = (newCategory.totalAmount! + enteredAmount);
                          categoryController.updateCategory(newCategory);
                          Get.snackbar('Success', "Your spent is saved");
                          amountController.clear();
                          descriptionController.clear();
                          dateController.clear();
                        }
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      initialDate: categoryController.selectedDate ?? DateTime.now(),
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != categoryController.selectedDate) {
      final formattedDate = DateFormat("dd-MM-yyyy").format(picked);
      dateController.text = formattedDate;
      categoryController.selectedDate = picked;
      var categoryDate = categoryController.categoryList.firstWhereOrNull((cat) => cat.id == id);
      categoryDate?.date = picked.toString();
    }
  }
}

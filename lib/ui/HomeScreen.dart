import 'package:finly/controller/CategoryController.dart';
import 'package:finly/controller/IncomeController.dart';
import 'package:finly/controller/TransactionController.dart';
import 'package:finly/data/IconList.dart';
import 'package:finly/model/categoryModel/Category.dart';
import 'package:finly/ui/DetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final String id;

  HomeScreen({super.key, required this.id});

  CategoryController categoryController = Get.put(CategoryController());
  TransactionController transactionController = Get.put(TransactionController());
  IncomeController incomeController = Get.put(IncomeController());
  IconList iconList = IconList();
  Category category = Category(id: '', iconPoints: 0, fontFamily: '', iconFontPackage: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0, top: 45, bottom: 45, right: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.monetization_on_rounded,
                      size: 28,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Finly',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/addCategory');
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                        size: 24,
                        color: Colors.grey[700],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Add Category',
                        style: TextStyle(fontSize: 18, color: Colors.grey[700], fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/addIncome');
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                        size: 24,
                        color: Colors.grey[700],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Add Income',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 5),
                child: Text(
                  'Monthly Income',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              Obx(() {
                return Text(
                  '${incomeController.income.value}',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 5),
                child: Text(
                  'Monthly Expense',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              Obx(() {
                return Text(
                  '${transactionController.monthlyTotalExpanse.value}',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }),
              SizedBox(
                height: 30,
              ),
              Obx(() {
                return categoryController.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : categoryController.categoryList.isEmpty
                        ? Center(
                            child: Text('No Category Found'),
                          )
                        : Expanded(
                            child: GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: 1.7,
                              ),
                              itemCount: categoryController.categoryList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      DetailsScreen(
                                        categoryName: categoryController.categoryList.elementAt(index).categoryName ?? 'No Name',
                                        id: categoryController.categoryList.elementAt(index).id,
                                      ),
                                    );
                                  },
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Card(
                                                elevation: 2,
                                                color: Colors.grey[350],
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    categoryController.categoryList.elementAt(index).getIconData(),
                                                  ),
                                                ),
                                              ),
                                              Spacer(
                                                flex: 1,
                                              ),
                                              PopupMenuButton(
                                                itemBuilder: (BuildContext context) => <PopupMenuEntry<CategoryMenu>>[
                                                  PopupMenuItem(
                                                    child: Text(
                                                      'Edit',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      editCategory(context, category, id);
                                                    },
                                                  ),
                                                  PopupMenuItem(
                                                    child: Text(
                                                      'Delete',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    onTap: () async {
                                                      await categoryController.removeCategory(index);
                                                    },
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            categoryController.categoryList.elementAt(index).categoryName ?? '',
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
              }),
            ],
          )),
    );
  }

  Future<void> editCategory(BuildContext context, Category cat, String catId) async {
    TextEditingController categoryNameController = TextEditingController(text: cat.categoryName);
    TextEditingController budgetController = TextEditingController(text: cat.budgetAmount.toString());
    // IconData selectedIcon = IconData(cat.iconPoints, fontPackage: cat.iconFontPackage, fontFamily: cat.fontFamily);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            shadowColor: Colors.grey,
            elevation: 4,
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.33,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Edit Category',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: categoryNameController,
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
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                        hintText: 'Enter category name',
                        fillColor: Colors.grey[300],
                        filled: true,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: budgetController,
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
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                        hintText: 'Enter your monthly budget',
                        fillColor: Colors.grey[300],
                        filled: true,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.height,
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
                          double budgetAmount = double.tryParse(budgetController.text) ?? 0.0;
                          var updatedCategory = Category(
                            id: id,
                            iconPoints: cat.iconPoints,
                            fontFamily: cat.fontFamily,
                            iconFontPackage: cat.iconFontPackage,
                            categoryName: categoryNameController.text,
                            budgetAmount: budgetAmount,
                          );
                          await categoryController.updateCategory(updatedCategory);
                          Get.back();
                          Get.snackbar('Success', 'Category updated successfully');
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

enum CategoryMenu { edit, delete }

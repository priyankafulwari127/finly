import 'package:finly/controller/CategoryController.dart';
import 'package:finly/data/CategoryList.dart';
import 'package:finly/model/Category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCategory extends StatelessWidget {
  AddCategory({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController budgetController = TextEditingController();
  CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Category',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Category Name',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: nameController,
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
                hintText: 'Enter category name',
                fillColor: Colors.grey[300],
                filled: true,
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Category Icon',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 185,
              width: MediaQuery.of(context).size.height,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      12,
                    ),
                  ),
                ),
                elevation: 5,
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      itemCount: CategoryList().icons.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 1.1,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  12,
                                ),
                              ),
                            ),
                            color: Colors.grey[350],
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                CategoryList().icons.elementAt(
                                      index,
                                    ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
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
                hintText: 'Enter monthly budget',
                fillColor: Colors.grey[300],
                filled: true,
              ),
            ),
            Spacer(
              flex: 1,
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
                  if (nameController.text.isEmpty) {
                    Get.snackbar('Error', 'Please enter name');
                  } else {
                    double? budget = double.tryParse(budgetController.text) ?? 0.0;
                    var category = Category(
                      categoryName: nameController.text,
                      budgetAmount: budget,
                      totalAmount: 0.0,
                      spentAmount: 0.0,
                      description: '',
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      date: DateTime.now().toString(),
                    );
                    await categoryController.addCategory(category);
                    // await CategoryController().updateCategory(category);
                    nameController.clear();
                    budgetController.clear();
                    Get.snackbar("Success", "Category has been added");
                  }
                },
                child: Text(
                  'Create',
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
    );
  }
}

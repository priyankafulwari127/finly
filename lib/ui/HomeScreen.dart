import 'package:finly/controller/CategoryController.dart';
import 'package:finly/data/CategoryList.dart';
import 'package:finly/model/Category.dart';
import 'package:finly/ui/DetailsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  CategoryController categoryController = Get.put(CategoryController());

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
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.deepPurple,
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Get.toNamed('/addCategory');
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return categoryController.categoryList.isEmpty
              ? Center(child: Text("No Category Found"))
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1.7,
                  ),
                  itemCount: categoryController.categoryList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () async {
                        //saves the clicked category
                        SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();
                        sharedPreferences.setString(
                            'selected_category',
                            categoryController.categoryList
                                    .elementAt(index)
                                    .categoryName ??
                                '');
                        sharedPreferences.setString(
                            'selected_category_id',
                            categoryController.categoryList
                                    .elementAt(index)
                                    .id ??
                                '');
                        //navigates to the clicked category
                        Get.to(
                          DetailsScreen(
                            categoryName: categoryController.categoryList
                                    .elementAt(index)
                                    .categoryName ??
                                'No Name',
                            id: categoryController.categoryList
                                    .elementAt(index)
                                    .id ??
                                'no id',
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
                              Card(
                                elevation: 2,
                                color: Colors.grey[350],
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                      CategoryList().icons.elementAt(index)),
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                categoryController.categoryList
                                        .elementAt(index)
                                        .categoryName ??
                                    '',
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
                );
        }),
      ),
    );
  }
}

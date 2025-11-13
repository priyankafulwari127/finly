import 'package:finly/controller/CategoryController.dart';
import 'package:finly/data/IconList.dart';
import 'package:finly/ui/AddCategoryScreen.dart';
import 'package:finly/ui/DetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  CategoryController categoryController = Get.put(CategoryController());
  IconList iconList = IconList();

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
        child: Obx(
          () {
            return categoryController.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : categoryController.categoryList.isEmpty
                    ? Center(
                        child: Text('No Category Found'),
                      )
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
                            onTap: () {
                              Get.to(
                                DetailsScreen(
                                  categoryName: categoryController.categoryList
                                          .elementAt(index)
                                          .categoryName ??
                                      'No Name',
                                  id: categoryController.categoryList
                                      .elementAt(index)
                                      .id,
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
                                              categoryController.categoryList
                                                  .elementAt(index)
                                                  .getIconData(),
                                            ),
                                          ),
                                        ),
                                        Spacer(
                                          flex: 1,
                                        ),
                                        PopupMenuButton(
                                          itemBuilder: (BuildContext context) =>
                                              <PopupMenuEntry<CategoryMenu>>[
                                            PopupMenuItem(
                                              child: Text(
                                                'Edit',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              onTap: () {
                                                Get.to(
                                                  AddCategory(
                                                      // category: categoryController.categoryHive.getCategoryById(
                                                      //   categoryController.categoryList.elementAt(index).id!,
                                                      // ),
                                                      ),
                                                );
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
                                                await categoryController
                                                    .removeCategory(index);
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
          },
        ),
      ),
    );
  }
}

enum CategoryMenu { edit, delete }

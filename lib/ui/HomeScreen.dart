import 'package:finly/model/Category.dart';
import 'package:finly/ui/DetailsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  List<Category> categories = [
    Category(
      categoryName: 'Bills',
      totalAmount: '0',
      id: '1',
    ),
    Category(
      categoryName: 'Entertainment',
      totalAmount: '0',
      id: '2',
    ),
    Category(
      categoryName: 'Travel',
      totalAmount: '0',
      id: '3',
    ),
    Category(
      categoryName: 'Food',
      totalAmount: '0',
      id: '4',
    ),
    Category(
      categoryName: 'Marriage',
      totalAmount: '0',
      id: '5',
    ),
    Category(
      categoryName: 'Shopping',
      totalAmount: '0',
      id: '6',
    ),
    Category(
      categoryName: 'Savings',
      totalAmount: '0',
      id: '7',
    ),
    Category(
      categoryName: 'Investment',
      totalAmount: '0',
      id: '8',
    ),
    Category(
      categoryName: 'Health & Medicines',
      totalAmount: '0',
      id: '9',
    ),
    Category(
      categoryName: 'Accounts Management',
      totalAmount: '0',
      id: '10',
    ),
    Category(
      categoryName: 'Credit Card Management',
      totalAmount: '0',
      id: '11',
    ),
  ];

  var icons = {
    CupertinoIcons.doc_text,
    CupertinoIcons.music_note_2,
    CupertinoIcons.train_style_one,
    CupertinoIcons.play_circle,
    CupertinoIcons.antenna_radiowaves_left_right,
    CupertinoIcons.shopping_cart,
    CupertinoIcons.creditcard,
    CupertinoIcons.money_dollar,
    CupertinoIcons.heart,
    CupertinoIcons.gift,
    CupertinoIcons.money_euro,
    CupertinoIcons.money_dollar_circle,
    CupertinoIcons.money_dollar_circle_fill,
  };

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
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.7,
          ),
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () async {
                //saves the clicked category
                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.setString(
                  'selected_category',
                  categories.elementAt(index).categoryName,
                );
                Get.to(
                  DetailsScreen(
                    categoryName: categories.elementAt(index).categoryName,
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
                          child: Icon(icons.elementAt(index)),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        categories.elementAt(index).categoryName,
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
      ),
    );
  }
}

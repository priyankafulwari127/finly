import 'package:finly/controller/CategoryController.dart';
import 'package:finly/localStorage/hiveDatabase.dart';
import 'package:finly/main.dart';
import 'package:finly/model/Category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class TransactionHistory extends StatelessWidget {
  final double spentAmount;
  final String description;
  final String date;
  final String id;

  TransactionHistory({
    super.key,
    required this.id,
    required this.spentAmount,
    required this.description,
    required this.date,
  });

  CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    var category = categoryController.categoryList.firstWhereOrNull((cat) => cat.id == id);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transaction History',
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
      body: ValueListenableBuilder<Box<Category>>(
        valueListenable: HiveDatabase.getTransactions().listenable(),
        builder: (context, box, _) {
          final transactions = box.values.toList(); //TODO
          return Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        category?.description as String,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        category?.date as String,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Text(
                    category?.spentAmount as String,
                    style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:finly/controller/CategoryController.dart';
import 'package:finly/controller/TransactionController.dart';
import 'package:finly/localStorage/CategoryHive.dart';
import 'package:finly/main.dart';
import 'package:finly/model/categoryModel/Category.dart';
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
  final String categoryId;

  TransactionHistory({
    super.key,
    required this.spentAmount,
    required this.description,
    required this.date,
    required this.categoryId,
  });

  TransactionController transactionController = Get.put(TransactionController());
  CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    var transaction = transactionController.transactionList.firstWhereOrNull(
      (transact) => transact.categoryId == categoryId,
    );

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: transactionController.transactionList.length,
          itemBuilder: (context, index) {
            return transactionController.transactionList.isEmpty
                ? Text("No Transactions Found")
                : transactionController.isLoading.value
                    ? CircularProgressIndicator()
                    : Card(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    transaction!.description!,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    transaction.date!,
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
                                transaction.currentSpentAmount.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
          },
        ),
      ),
    );
  }
}

import 'package:finly/controller/CategoryController.dart';
import 'package:finly/controller/TransactionController.dart';
import 'package:finly/localStorage/CategoryHive.dart';
import 'package:finly/main.dart';
import 'package:finly/model/categoryModel/Category.dart';
import 'package:finly/model/transactionModel/Transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return Row(
                children: [
                  Text(
                    '${DateFormat.MMMM().format(transactionController.selectedMonth.value)}, ${transactionController.selectedMonth.value.year}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  IconButton(
                    onPressed: () {
                      transactionController.changeMonth(
                        DateTime(transactionController.selectedMonth.value.year, transactionController.selectedMonth.value.month - 1),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 20,
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  IconButton(
                    onPressed: () {
                      transactionController.changeMonth(
                        DateTime(transactionController.selectedMonth.value.year, transactionController.selectedMonth.value.month + 1),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20,
                    ),
                  ),
                ],
              );
            }),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: Obx(() {
                var transactions = transactionController.filterTransactionListMonthly(transactionController.selectedMonth.value, catId: categoryId);
                return transactions.isEmpty
                    ? Text("No Transaction found")
                    : ListView.builder(
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        transactions.elementAt(index).description,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        transactions.elementAt(index).date,
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
                                    transactions.elementAt(index).currentSpentAmount.toString(),
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
                      );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

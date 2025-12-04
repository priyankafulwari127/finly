import 'package:finly/localStorage/TransactionHive.dart';
import 'package:finly/main.dart';
import 'package:finly/model/transactionModel/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hive_flutter/adapters.dart';

class TransactionController extends GetxController {
  TransactionHive transactionHive = TransactionHive();

  RxBool isLoading = false.obs;
  var allTransactionList = <Transaction>[].obs;
  var monthlyTransactionList = <Transaction>[].obs;
  var monthlyTotalExpanse = 0.0.obs;
  var selectedMonth = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    allTransactionList.value = transactionHive.getAllTransactions();
    getMonthlyTotalExpense();

    transactionHive.transactionBox.listenable().addListener(() {
      getMonthlyTotalExpense();
    });
    filterTransactionListMonthly(selectedMonth.value);
  }

  Future<void> addTransaction(Transaction transaction) async {
    allTransactionList.add(transaction);
    await transactionHive.addTransaction(transaction);
    filterTransactionListMonthly(selectedMonth.value);
  }

  double getTotalByCategory(String categoryId) {
    var total = 0.0;
    var currentMonth = DateTime.now().month;
    int currentYear = DateTime.now().year;
    for (var t in allTransactionList) {
      DateTime date = parseDmyDate(t.date);
      if (t.categoryId == categoryId && date.month == currentMonth && date.year == currentYear) {
        total += t.currentSpentAmount;
      }
    }
    return total;
  }

  void getMonthlyTotalExpense() {
    double expense = 0.0;
    int currentMonth = DateTime.now().month;
    int currentYear = DateTime.now().year;
    for (var t in transactionHive.transactionBox.values) {
      DateTime monthlyDate = parseDmyDate(t.date);
      if (monthlyDate.year == currentYear && monthlyDate.month == currentMonth) {
        expense += t.currentSpentAmount;
      }
      monthlyTotalExpanse.value = expense;
    }
  }

  DateTime parseDmyDate(String dateString) {
    final parts = dateString.split('-');
    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);
    return DateTime(year, month, day);
  }

  List<Transaction> filterTransactionListMonthly(DateTime month, {String catId = ''}) {
    monthlyTransactionList.clear();
    for (var transaction in allTransactionList) {
      DateTime date = parseDmyDate(transaction.date);
      if (date.year == month.year && date.month == month.month) {
        monthlyTransactionList.add(transaction);
        print("category Id: $catId");
        print("current month: ${date.month}, ${date.year}");
      }
    }
    //sorting the transaction list
    monthlyTransactionList.sort((a, b) => b.date.compareTo(a.date));
    if (catId.isNotEmpty) {
      return monthlyTransactionList.where((t) => t.categoryId == catId).toList();
    }
    return [];
  }

  void changeMonth(DateTime newMonth) {
    selectedMonth.value = newMonth;
    filterTransactionListMonthly(newMonth);
  }
}

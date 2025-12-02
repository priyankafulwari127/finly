import 'package:finly/localStorage/TransactionHive.dart';
import 'package:finly/main.dart';
import 'package:finly/model/transactionModel/Transaction.dart';
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
    _loadTransactions();
    getMonthlyTotalExpense();

    transactionHive.transactionBox.listenable().addListener(() {
      getMonthlyTotalExpense();
    });
    _filterTransactionListMonthly(selectedMonth.value);
  }

  void _loadTransactions(){
    return allTransactionList.assignAll(transactionHive.getAllTransactions());
  }

  List<Transaction> getMonthlyTransactionByCategoryId(String categoryId){
    transactionHive.getTransactionsByCategory(categoryId);
    return monthlyTransactionList.where((c) => c.categoryId == categoryId).toList();
  }

  Future<void> addTransaction(Transaction transaction) async {
    allTransactionList.add(transaction);
    await transactionHive.addTransaction(transaction);
    _filterTransactionListMonthly(selectedMonth.value);
  }

  void getMonthlyTotalExpense() {
    double total = 0.0;
    int currentMonth = DateTime.now().month;
    int currentYear = DateTime.now().year;
    for (var t in transactionHive.transactionBox.values) {
      DateTime monthlyDate = parseDmyDate(t.date);
      if (monthlyDate.year == currentYear && monthlyDate.month == currentMonth) {
        total += t.currentSpentAmount;
      } else {
        total = 0.0;
      }
      monthlyTotalExpanse.value = total;
    }
  }

  DateTime parseDmyDate(String dateString) {
    final parts = dateString.split('-');
    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);
    return DateTime(year, month, day);
  }

  void _filterTransactionListMonthly(DateTime month) {
    monthlyTransactionList.clear();
    for (var transaction in allTransactionList) {
      DateTime date = parseDmyDate(transaction.date);
      if (date.year == month.year && date.month == month.month) {
        monthlyTransactionList.add(transaction);
      }
    }
    //sorting the transaction list
    monthlyTransactionList.sort((a, b) => b.date.compareTo(a.date));
  }

  void changeMonth(DateTime newMonth) {
    selectedMonth.value = newMonth;
    _filterTransactionListMonthly(newMonth);
  }
}

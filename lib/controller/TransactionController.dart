import 'package:finly/localStorage/TransactionHive.dart';
import 'package:finly/main.dart';
import 'package:finly/model/transactionModel/Transaction.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hive_flutter/adapters.dart';

class TransactionController extends GetxController{
  TransactionHive transactionHive = TransactionHive();

  RxBool isLoading = false.obs;
  var transactionList = <Transaction>[].obs;
  var monthlyTotalExpanse = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    transactionList.value = transactionHive.getAllTransactions();
    getMonthlyTotalExpense();

    transactionHive.transactionBox.listenable().addListener(() {
      getMonthlyTotalExpense();
    });
  }

  Future<void> updateTransaction(String transactionId, Transaction transaction)async{
    transactionList.add(transaction);
    await transactionHive.updateTransaction(transactionId, transaction);
  }

  void getMonthlyTotalExpense(){
    double total = 0.0;

    int currentMonth = DateTime.now().month;
    int currentYear = DateTime.now().year;

    for(var t in transactionHive.transactionBox.values){
      DateTime monthlyDate = parseDmyDate(t.date);

      if(monthlyDate.year == currentYear && monthlyDate.month == currentMonth){
        total += t.currentSpentAmount;
      }else{
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
}
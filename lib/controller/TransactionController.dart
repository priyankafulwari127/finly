import 'package:finly/localStorage/TransactionHive.dart';
import 'package:finly/model/transactionModel/Transaction.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class TransactionController extends GetxController{
  TransactionHive transactionHive = TransactionHive();

  RxBool isLoading = false.obs;
  var transactionList = <Transaction>[].obs;
  var totalExpanse = 0.0;

  @override
  void onInit() {
    super.onInit();
    transactionList.value = transactionHive.getAllTransactions();
    // getTotalAmountOfAllCategory(transactionList);
    for(var transaction in transactionList){
      totalExpanse += transaction.currentSpentAmount;
    }
  }

  Future<void> updateTransaction(String transactionId, Transaction transaction)async{
    transactionList.add(transaction);
    await transactionHive.updateTransaction(transactionId, transaction);
  }

  double getTotalAmountOfAllCategory(List<Transaction> transactionList){
    var totalExpanse = 0.0;
    for(var transaction in transactionList){
      return totalExpanse += transaction.currentSpentAmount;
    }
    return 0.0;
  }
}
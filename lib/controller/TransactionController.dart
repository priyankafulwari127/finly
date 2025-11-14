import 'package:finly/localStorage/TransactionHive.dart';
import 'package:finly/model/transactionModel/Transaction.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class TransactionController extends GetxController{
  TransactionHive transactionHive = TransactionHive();

  RxBool isLoading = false.obs;
  var transactionList = <Transaction>[].obs;

  @override
  void onInit() {
    super.onInit();
    transactionList.value = transactionHive.getAllTransactions();
  }

  Future<void> updateTransaction(String transactionId, Transaction transaction)async{
    transactionList.add(transaction);
    await transactionHive.updateTransaction(transactionId, transaction);
  }
}
import 'dart:ffi';

import 'package:hive/hive.dart';
import '../model/transactionModel/Transaction.dart';

class TransactionHive {
  Box<Transaction> transactionBox = Hive.box<Transaction>('transaction');

  Future<void> updateTransaction(String transactionId, Transaction transaction) async {
    transactionBox.put(transactionId, transaction);
  }

  List<Transaction> getTransactionsByCategory(String categoryId) {
    return transactionBox.values.where((transaction) => transaction.categoryId == categoryId).toList();
  }

  double getTotalByCategory(String categoryId) {
    var expanse = 0.0;
    for (var t in transactionBox.values) {
      if(t.categoryId==categoryId) {
        expanse += t.currentSpentAmount;
      }
    }
    return expanse;
  }

  List<Transaction> getAllTransactions() {
    return transactionBox.values.toList();
  }
}

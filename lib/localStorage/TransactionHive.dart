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

  List<Transaction> getAllTransactions() {
    return transactionBox.values.toList();
  }
}

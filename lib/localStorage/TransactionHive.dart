import 'package:hive/hive.dart';
import '../model/transactionModel/Transaction.dart';

class TransactionHive{
  Box<Transaction> transactionBox = Hive.box<Transaction>('transaction');

  Future<void> addTransaction(Transaction transaction)async{
    transactionBox.add(transaction);
  }

  List<Transaction> getTransactions(){
    return transactionBox.values.toList();
  }
}
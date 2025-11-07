import 'package:hive/hive.dart';
part 'Transaction.g.dart';

@HiveType(typeId: 1)
class Transaction {
  @HiveField(0)
  double? currentSpentAmount;
  @HiveField(1)
  String? description;
  @HiveField(2)
  String? date;
  @HiveField(3)
  String? transactionId;
  @HiveField(4)
  String? categoryId;

  Transaction({
    this.currentSpentAmount,
    this.description,
    this.date,
    this.transactionId,
    this.categoryId,
  });
}

import 'package:hive_flutter/adapters.dart';
part 'Category.g.dart';

@HiveType(typeId: 0)
class Category {
  @HiveField(0)
  String? categoryName;
  @HiveField(1)
  double? totalAmount;
  @HiveField(2)
  String? id;
  @HiveField(3)
  String? description;
  @HiveField(4)
  String? date;
  @HiveField(5)
  double? budgetAmount;

  Category({
    this.categoryName,
    this.totalAmount,
    this.id,
    this.budgetAmount,
    this.date,
    this.description,
  });

  //option : if saving data to json
  Map<String, dynamic> toJson() => {
        'categoryName': categoryName,
        'totalAmount': totalAmount,
        'id': id,
        'description': description,
        'date': date,
        'budgetAmount': budgetAmount,
      };

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'],
        categoryName: json['categoryName'],
        totalAmount: json['totalAmount'],
        budgetAmount: json['budgetAmount'],
        date: json['date'],
        description: json['description'],
      );
}

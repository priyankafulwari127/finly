import 'package:flutter/cupertino.dart';
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
  @HiveField(6)
  final int iconPoints;
  @HiveField(7)
  final String fontFamily;
  @HiveField(8)
  final String iconFontPackage;

  Category({
    this.categoryName,
    this.totalAmount,
    this.id,
    this.budgetAmount,
    this.date,
    this.description,
    required this.iconPoints,
    required this.fontFamily,
    required this.iconFontPackage,
  });

  IconData getIconData(){
    return IconData(iconPoints, fontFamily: fontFamily, fontPackage: iconFontPackage);
  }
}

class Category {
  String? categoryName;
  double? totalAmount;
  String? id;
  double? spentAmount;
  String? description;
  DateTime? date;
  double? budgetAmount;

  Category({
    this.categoryName,
    this.totalAmount,
    this.id,
    this.spentAmount,
    this.budgetAmount,
    this.date,
    this.description,
  });

  //option : if saving data to json
  Map<String, dynamic> toJson() => {
        'categoryName': categoryName,
        'totalAmount': totalAmount,
        'id': id,
        'spentAmount': spentAmount,
        'description': description,
        'date': date,
        'budgetAmount': budgetAmount,
      };

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'],
        categoryName: json['categoryName'],
        totalAmount: json['totalAmount'],
        spentAmount: json['spentAmount'],
        budgetAmount: json['budgetAmount'],
        date: json['date'],
        description: json['description'],
      );
}

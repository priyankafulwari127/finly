class Category {
  final String categoryName;
  double totalAmount;
  final String id;
  double? spentAmount;
  final String? description;
  DateTime? date;
  double? budgetAmount;

  Category({
    required this.categoryName,
    required this.totalAmount,
    required this.id,
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

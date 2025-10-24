class Category {
  final String categoryName;
  final String totalAmount;
  final String id;

  Category({
    required this.categoryName,
    required this.totalAmount,
    required this.id,
  });

  //option : if saving data to json
  Map<String, dynamic> toJson() => {
        'categoryName': categoryName,
        'totalAmount': totalAmount,
        'id': id,
      };

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'],
        categoryName: json['categoryName'],
        totalAmount: json['totalAmount'],
      );
}

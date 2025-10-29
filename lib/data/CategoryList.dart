import 'package:flutter/cupertino.dart';

import '../model/Category.dart';

class CategoryList {
  List<Category> categories = [
    Category(
      categoryName: 'Bills',
      totalAmount: 0.0,
      id: '1',
    ),
    Category(
      categoryName: 'Entertainment',
      totalAmount: 0.0,
      id: '2',
    ),
    Category(
      categoryName: 'Travel',
      totalAmount: 0.0,
      id: '3',
    ),
    Category(
      categoryName: 'Food',
      totalAmount: 0.0,
      id: '4',
    ),
    Category(
      categoryName: 'Marriage',
      totalAmount: 0.0,
      id: '5',
    ),
    Category(
      categoryName: 'Shopping',
      totalAmount: 0.0,
      id: '6',
    ),
    Category(
      categoryName: 'Savings',
      totalAmount: 0.0,
      id: '7',
    ),
    Category(
      categoryName: 'Investment',
      totalAmount: 0.0,
      id: '8',
    ),
    Category(
      categoryName: 'Health & Medicines',
      totalAmount: 0.0,
      id: '9',
    ),
    Category(
      categoryName: 'Accounts Management',
      totalAmount: 0.0,
      id: '10',
    ),
    Category(
      categoryName: 'Credit Card Management',
      totalAmount: 0.0,
      id: '11',
    ),
  ];
  var icons = {
    CupertinoIcons.doc_text,
    CupertinoIcons.music_note_2,
    CupertinoIcons.train_style_one,
    CupertinoIcons.play_circle,
    CupertinoIcons.antenna_radiowaves_left_right,
    CupertinoIcons.shopping_cart,
    CupertinoIcons.creditcard,
    CupertinoIcons.money_dollar,
    CupertinoIcons.heart,
    CupertinoIcons.gift,
    CupertinoIcons.money_euro,
    CupertinoIcons.money_dollar_circle,
    CupertinoIcons.money_dollar_circle_fill,
  };
}

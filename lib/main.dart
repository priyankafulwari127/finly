import 'package:finly/model/categoryModel/Category.dart';
import 'package:finly/model/transactionModel/Transaction.dart';
import 'package:finly/ui/AddCategoryScreen.dart';
import 'package:finly/ui/DetailsScreen.dart';
import 'package:finly/ui/HomeScreen.dart';
import 'package:finly/ui/TransactionHistory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(TransactionAdapter());
  await Hive.openBox<Category>('category');
  await Hive.openBox<Transaction>('transaction');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: "/home",
      routes: {
        '/home': (context) => HomeScreen(),
        '/details': (context) => DetailsScreen(
              categoryName: '',
              id: '',
            ),
        '/addCategory': (context) => AddCategory(),
        '/transactionHistory': (context) => TransactionHistory(
              spentAmount: 0.0,
              description: '',
              date: '',
              categoryId: '',
            ),
      },
    );
  }
}

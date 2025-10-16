import 'package:finly/ui/AddCategoryScreen.dart';
import 'package:finly/ui/DetailsScreen.dart';
import 'package:finly/ui/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
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
        '/details': (context) => DetailsScreen(),
        '/addCategory': (context) => AddCategory(),
      },
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  var categories = {
    "Housing",
    "Bills",
    "Entertainment",
    "Transportation",
    "Food",
    "Utilities",
    "Shopping",
    "Credit Management",
    "Accounts Management",
    "Health & Medicine",
    "Gift",
    "Savings",
    "Investment",
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: ListView.builder(
        itemCount: ,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text("Category Name"),
                  Spacer(flex: 1),
                  Text("Amount"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

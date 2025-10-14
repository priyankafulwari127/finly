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
    "Assets",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        categories.elementAt(index),
                        style: TextStyle(fontSize: 20),
                      ),
                      Spacer(flex: 1),
                      Text("Amount", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

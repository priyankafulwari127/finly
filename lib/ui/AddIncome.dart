import 'package:finly/controller/IncomeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddIncome extends StatelessWidget {
  AddIncome({super.key});

  TextEditingController incomeTextController = TextEditingController();
  IncomeController incomeController = Get.find<IncomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Income',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Income Name',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: incomeTextController,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      12,
                    ),
                  ),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      12,
                    ),
                  ),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Enter income',
                fillColor: Colors.grey[300],
                filled: true,
              ),
              keyboardType: TextInputType.number,
            ),
            Spacer(
              flex: 1,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.height,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        12,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  if (incomeTextController.text.isEmpty) {
                    Get.snackbar('Error', 'Please enter your income');
                  } else {
                    double income = double.tryParse(incomeTextController.text) ?? 0.0;
                    incomeController.saveIncome(income);
                    Get.snackbar("Success", "Income has been added");
                    incomeTextController.clear();
                  }
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

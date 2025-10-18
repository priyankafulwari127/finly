import 'package:finly/controller/DetailsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsScreen extends StatelessWidget {
  final String categoryName;

  DetailsScreen({super.key, required this.categoryName});

  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController budgetController = TextEditingController();

  DetailsController detailsController = Get.put(DetailsController());
  var isAmountAdded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Center(
                child: Text(
                  'Your total outstanding amount',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[550],
                  ),
                ),
              ),
              Obx(() {
                return Center(
                  child: Text(
                    "${detailsController.totalAmount.value}",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                );
              }),
              SizedBox(
                height: 40,
              ),
              Text(
                'Amount',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                onChanged: (value) async {
                  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  double amount = double.tryParse(value) ?? 0.0;
                  if (amount > detailsController.budgetAmount.value) {
                    Get.snackbar(
                      'Error',
                      'Your amount is higher than your monthly budget',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
                controller: amountController,
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
                  hintText: 'Enter spent amount',
                  fillColor: Colors.grey[300],
                  filled: true,
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Description',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: descriptionController,
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
                  hintText: 'Enter Description',
                  fillColor: Colors.grey[300],
                  filled: true,
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Date',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                onTap: () {
                  _selectDate(context);
                },
                controller: dateController,
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
                  prefixIcon: Icon(Icons.calendar_month),
                  hintText: 'DD-MM-YYYY',
                  fillColor: Colors.grey[300],
                  filled: true,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Set Budget',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: budgetController,
                onChanged: (value) async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  double budget = double.tryParse(value) ?? 0.0;
                  prefs.setDouble('budget', budget);
                  detailsController.budgetAmount.value = budget;
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        12,
                      ),
                    ),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        12,
                      ),
                    ),
                    borderSide: BorderSide.none,
                  ),
                  hintText: isAmountAdded ? '' : 'Enter monthly budget',
                  fillColor: Colors.grey[300],
                  filled: true,
                ),
                keyboardType: TextInputType.number,
              ),
              Spacer(
                flex: 1,
              ),
              SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .height,
                height: 50,
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
                  onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    double enteredAmount = double.tryParse(amountController.text) ?? 0.0;
                    if (amountController.text.isEmpty) {
                      Get.snackbar('Error', 'Please enter amount');
                    } else if (dateController.text.isEmpty) {
                      Get.snackbar('Error', 'Please select date');
                    } else if (budgetController.text.isEmpty) {
                      Get.snackbar('Error', 'Please enter budget');
                    } else if (enteredAmount >= detailsController.budgetAmount.value) {
                      Get.snackbar('Error', 'Spent amount is greater than budget');
                    } else {
                      if (enteredAmount <= detailsController.budgetAmount.value) {
                        var addedAmount = detailsController.totalAmount.value + enteredAmount;
                        detailsController.totalAmount.value = addedAmount;
                      }
                      prefs.setDouble('totalAmount', detailsController.totalAmount.value);
                      Get.snackbar('Success', "Your spent is saved");
                      Get.back();
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
          )
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      initialDate: detailsController.selectedDate ?? DateTime.now(),
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != detailsController.selectedDate) {
      final formattedDate = DateFormat("dd-MM-yyyy").format(picked);
      dateController.text = formattedDate;
      detailsController.selectedDate = picked;
    }
  }
}

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeController extends GetxController{
  var income = 0.0.obs;

  @override
  void onInit(){
    super.onInit();
    getIncome();
  }

  Future<void> saveIncome(double text)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setDouble('income', text);
    income.value = text;
  }

  Future<void> getIncome()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.getDouble('income');
  }
}
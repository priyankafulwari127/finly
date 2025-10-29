import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsController extends GetxController{
  DateTime? selectedDate;
  var isLoading = false.obs;
  var budgetAmount = 0.0.obs;
  var totalAmount = 0.0.obs;

  Future<void> loadTotalAmount() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    totalAmount.value = sharedPreferences.getDouble('totalAmount') ?? 0.0;
    budgetAmount.value = sharedPreferences.getDouble('budget') ?? 0.0;
  }

  @override
  void onInit() {
    loadTotalAmount();
  }
}
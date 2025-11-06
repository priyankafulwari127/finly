import 'package:finly/model/Category.dart';
import 'package:hive/hive.dart';

class HiveDatabase{
  Box<Category> myBox = Hive.box<Category>('category');

  Future<void> addCategory(List<Category> category) async{
    myBox.addAll(category);
  }

  List<Category> getAllCategories(){
    return myBox.values.toList();
  }

  Future<void> addTransaction(Category category)async{
    myBox.add(category);
  }

  static Box<Category> getTransactions(){
    return Hive.box<Category>('category');
  }

  Future<void> updateTransaction(int index, Category category)async{
    myBox.putAt(index, category);
  }

  Future<void> deleteTransaction(int index)async{
    myBox.deleteAt(index);
  }
}
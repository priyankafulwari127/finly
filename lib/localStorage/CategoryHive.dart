import 'package:finly/model/categoryModel/Category.dart';
import 'package:hive/hive.dart';

class CategoryHive{
  Box<Category> categoryBox = Hive.box<Category>('category');

  Future<void> addCategory(Category category) async{
    categoryBox.add(category);
  }

  List<Category> getAllCategories(){
    return categoryBox.values.toList();
  }
}
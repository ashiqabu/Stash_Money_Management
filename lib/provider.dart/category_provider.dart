import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:stash_project/models/category/category_model.dart';

class CategoryProvider with ChangeNotifier {
  CategoryType? selectedCategorytype;
  CategoryModel? selectedCategoryModel;
  String? categoryID;
  DateTime? selectedDate;

  List<CategoryModel> incomeCategoryList = [];
  List<CategoryModel> expenseCategoryList = [];

  Future<void> insertCategory(CategoryModel value) async {
    final categoryDB = await Hive.openBox<CategoryModel>('category');
    await categoryDB.put(value.id, value);
    refreshUI();
  }

  Future<List<CategoryModel>> getCategories() async {
    final categoryDB = await Hive.openBox<CategoryModel>('category');
    return categoryDB.values.toList();
  }

  Future<void> refreshUI() async {
    final allCategories = await getCategories();
    incomeCategoryList.clear();
    expenseCategoryList.clear();
    notifyListeners();

    await Future.forEach(allCategories, (CategoryModel category) {
      if (category.type == CategoryType.income) {
        incomeCategoryList.add(category);
      } else {
        expenseCategoryList.add(category);
      }
    });
    notifyListeners();
  }

  Future<void> deleteCategorys(String categoryID) async {
    final categoryDB = await Hive.openBox<CategoryModel>('category');
    await categoryDB.delete(categoryID);
    refreshUI();
  }

  void radioIncome() {
    selectedCategorytype = CategoryType.income;
    categoryID = null;
    notifyListeners();
  }

  void radioExpense() {
    selectedCategorytype = CategoryType.expense;
    categoryID = null;
    notifyListeners();
  }

  void selectedCategoryOnchanged(String selectedValue) {
    categoryID = selectedValue;
    notifyListeners();
  }

  void selectedCategoryOntap(CategoryModel? e) {
    selectedCategoryModel = e;
    notifyListeners();
  }

  void pickDate(selectedDateTemp) {
    selectedDate = selectedDateTemp;
    notifyListeners();
  }
}

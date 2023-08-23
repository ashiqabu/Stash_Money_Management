// import 'package:flutter/foundation.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:stash_project/models/category/category_model.dart';
// import 'package:stash_project/screens/category/addcategorypop_up.dart';

// // ignore: constant_identifier_names
// const CATEGORY_DB_NAME = 'category-database';

// abstract class CategoryDBfunctions {
//   Future<List<CategoryModel>> getCategories();
//   Future<void> insertCategory(CategoryModel value);
//   Future<void> deleteCategory(String categoryId);
// }

// class CategoryDB implements CategoryDBfunctions {
//   CategoryDB._internal();
//   static CategoryDB instance = CategoryDB._internal();
//   factory CategoryDB() {
//     return instance;
//   }

//   ValueNotifier<List<CategoryModel>> incomeCAtegoryListListener =
//       ValueNotifier([]);
//   ValueNotifier<List<CategoryModel>> expanseCAtegoryListListener =
//       ValueNotifier([]);

//   @override
//   Future<void> insertCategory(CategoryModel value) async {
//     // ignore: non_constant_identifier_names
//     final CategoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
//     await CategoryDB.put(value.id, value);
//     refreshUI();
//   }

//   @override
//   Future<List<CategoryModel>> getCategories() async {
//     // ignore: non_constant_identifier_names
//     final CategoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
//     // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
//     selectedCategoryNotifier.notifyListeners();
//     return CategoryDB.values.toList();
//   }

//   Future<void> refreshUI() async {
//     final allCategories = await getCategories();
//     incomeCAtegoryListListener.value.clear();
//     expanseCAtegoryListListener.value.clear();
//     await Future.forEach(
//       allCategories,
//       (CategoryModel category) {
//         if (category.type == CategoryType.income) {
//           incomeCAtegoryListListener.value.add(category);
//         } else {
//           expanseCAtegoryListListener.value.add(category);
//         }
//       },
//     );

//     // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
//     incomeCAtegoryListListener.notifyListeners();
//     // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
//     expanseCAtegoryListListener.notifyListeners();
//   }

//   @override
//   Future<void> deleteCategory(String categoryId) async {
//     final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
//     categoryDB.delete(categoryId);
//     refreshUI();
//   }
// }

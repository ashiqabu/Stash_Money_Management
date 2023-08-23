// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:stash_project/models/transaction/transaction_model.dart';

// import '../../models/category/category_model.dart';

// // ignore: constant_identifier_names
// const TRANSACTION_DB_NAME = 'transaction-db';

// abstract class TransactionDbFunction {
//   Future<void> addTransaction(TranscationModel obj);
//   Future<List<TranscationModel>> getAllTransaction();
//   Future<void> deletTransaction(int index);
// }

// class TransactionDb implements TransactionDbFunction {
//   TransactionDb.internal();
//   static TransactionDb instance = TransactionDb.internal();
//   factory TransactionDb() {
//     return instance;
//   }

//   ValueNotifier<List<TranscationModel>> transactionListNotifier =
//       ValueNotifier([]);
//   String? selectedCatogory;

//   @override
//   Future<void> addTransaction(TranscationModel obj) async {
//     final db = await Hive.openBox<TranscationModel>(TRANSACTION_DB_NAME);
//     await db.add(obj);
//   }

//   Future<void> refresh() async {
//     final list = await getAllTransaction();
//     list.sort((first, second) => second.date.compareTo(first.date));
//     transactionListNotifier.value.clear();
//     transactionListNotifier.value.addAll(list);
//     // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
//     transactionListNotifier.notifyListeners();
//   }

//   @override
//   Future<List<TranscationModel>> getAllTransaction() async {
//     final db = await Hive.openBox<TranscationModel>(TRANSACTION_DB_NAME);
//     return db.values.toList();
//   }

//   @override
//   Future<void> deletTransaction(int id) async {
//     final db = await Hive.openBox<TranscationModel>(TRANSACTION_DB_NAME);
//     db.deleteAt(id);
//     refresh();
//   }

//   Future<void> editTransactionDb(int id, TranscationModel model) async {
//     final db = await Hive.openBox<TranscationModel>(TRANSACTION_DB_NAME);
//     await db.putAt(id, model);
//     transactionListNotifier.value.clear();
//     transactionListNotifier.value.addAll(db.values);
//     getAllTransaction();
//   }

//   Future<void> search(String text) async {
//     final db = await Hive.openBox<TranscationModel>(TRANSACTION_DB_NAME);
//     List<TranscationModel>? filteredList;

//     if (selectedCatogory == 'Income') {
//       filteredList = db.values
//           .where((element) =>
//               element.type == CategoryType.income &&
//               element.category.name
//                   .toLowerCase()
//                   .trim()
//                   .contains(text.toLowerCase()))
//           .toList();
//     } else if (selectedCatogory == 'Expense') {
//       filteredList = db.values
//           .where((element) =>
//               element.type == CategoryType.expense &&
//               element.category.name
//                   .toLowerCase()
//                   .trim()
//                   .contains(text.toLowerCase()))
//           .toList();
//     } else if (selectedCatogory == "All") {
//       filteredList = db.values
//           .where((element) => element.category.name
//               .toLowerCase()
//               .trim()
//               .contains(text.toLowerCase()))
//           .toList();
//     } else {
//       filteredList = db.values
//           .where((element) => element.category.name
//               .toLowerCase()
//               .trim()
//               .contains(text.toLowerCase()))
//           .toList();
//     }
//     transactionListNotifier.value.clear();
//     transactionListNotifier.value.addAll(filteredList);
//     // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
//     transactionListNotifier.notifyListeners();
//   }

//   Future<void> filterDataByDate(String dateRange) async {
//     // ignore: non_constant_identifier_names
//     final TransactionDb =
//         await Hive.openBox<TranscationModel>(TRANSACTION_DB_NAME);
//     List<TranscationModel> dateFilterList = [];
//     if (dateRange == 'today') {
//       if (selectedCatogory == "Income") {
//         dateFilterList = TransactionDb.values
//             .where((element) =>
//                 element.type == CategoryType.income &&
//                 element.date.day == DateTime.now().day &&
//                 element.date.month == DateTime.now().month &&
//                 element.date.year == DateTime.now().year)
//             .toList();
//       } else if (selectedCatogory == "Expense") {
//         dateFilterList = TransactionDb.values
//             .where((element) =>
//                 element.type == CategoryType.expense &&
//                 element.date.day == DateTime.now().day &&
//                 element.date.month == DateTime.now().month &&
//                 element.date.year == DateTime.now().year)
//             .toList();
//       } else {
//         dateFilterList = TransactionDb.values
//             .where((element) =>
//                 element.date.day == DateTime.now().day &&
//                 element.date.month == DateTime.now().month &&
//                 element.date.year == DateTime.now().year)
//             .toList();
//         // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
//         transactionListNotifier.notifyListeners();
//       }
//     } else if (dateRange == 'yesterday') {
//       if (selectedCatogory == "Income") {
//         dateFilterList = TransactionDb.values
//             .where((element) =>
//                 element.type == CategoryType.income &&
//                 element.date.day == DateTime.now().day - 1 &&
//                 element.date.month == DateTime.now().month &&
//                 element.date.year == DateTime.now().year)
//             .toList();
//       } else if (selectedCatogory == "Expense") {
//         dateFilterList = TransactionDb.values
//             .where((element) =>
//                 element.type == CategoryType.expense &&
//                 element.date.day == DateTime.now().day - 1 &&
//                 element.date.month == DateTime.now().month &&
//                 element.date.year == DateTime.now().year)
//             .toList();
//       } else {
//         dateFilterList = TransactionDb.values
//             .where((element) =>
//                 element.date.day == DateTime.now().day - 1 &&
//                 element.date.month == DateTime.now().month &&
//                 element.date.year == DateTime.now().year)
//             .toList();
//         // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
//         transactionListNotifier.notifyListeners();
//       }
//     } else if (dateRange == 'last week') {
//       final DateTime today = DateTime.now();
//       final DateTime weekAgo = today.subtract(const Duration(days: 7));

//       if (selectedCatogory == "Income") {
//         dateFilterList = TransactionDb.values
//             .where((element) =>
//                 element.type == CategoryType.income &&
//                 element.date.isAfter(weekAgo) &&
//                 element.date.isBefore(today))
//             .toList();
//       } else if (selectedCatogory == "Expense") {
//         dateFilterList = TransactionDb.values
//             .where((element) =>
//                 element.type == CategoryType.expense &&
//                 element.date.isAfter(weekAgo) &&
//                 element.date.isBefore(today))
//             .toList();
//       } else {
//         dateFilterList = TransactionDb.values
//             .where((element) =>
//                 element.date.isAfter(weekAgo) && element.date.isBefore(today))
//             .toList();
//       }
//     } else if (dateRange == 'all') {
//       refresh();
//     } else {
//       TransactionDb.values.toList();
//     }
//     transactionListNotifier.value.clear();
//     transactionListNotifier.value.addAll(dateFilterList);
//     // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
//     transactionListNotifier.notifyListeners();
//   }

//   Future<void> filter(String text) async {
//     if (text == 'Income') {
//       final transactionDB =
//           await Hive.openBox<TranscationModel>(TRANSACTION_DB_NAME);
//       transactionListNotifier.value.clear();
//       transactionListNotifier.value.addAll(transactionDB.values
//           .where((element) => element.type == CategoryType.income)
//           .toList());
//       selectedCatogory = "Income";
//       // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
//       transactionListNotifier.notifyListeners();
//     } else if (text == 'Expense') {
//       final transactionDB =
//           await Hive.openBox<TranscationModel>(TRANSACTION_DB_NAME);
//       transactionListNotifier.value.clear();
//       transactionListNotifier.value.addAll(transactionDB.values
//           .where((element) => element.type == CategoryType.expense)
//           .toList());
//       selectedCatogory = "Expense";

//       // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
//       transactionListNotifier.notifyListeners();
//     } else if (text == "All") {
//       selectedCatogory = "All";
//       refresh();
//       // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
//       transactionListNotifier.notifyListeners();
//     }
//   }
// }

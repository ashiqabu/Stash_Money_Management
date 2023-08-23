import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/category/category_model.dart';
import '../models/transaction/transaction_model.dart';

class TransactionProvider with ChangeNotifier {
  List<TranscationModel> transactionList = [];
  String? selectedCatogory;
  // String? categoryID;

  set selectedCategoryType(CategoryType selectedCategoryType) {}

  Future<void> addTransaction(TranscationModel obj) async {
    final db = await Hive.openBox<TranscationModel>('transactions');
    db.put(obj.id, obj);
    refresh();
    notifyListeners();
  }

  Future<void> refresh() async {
    final list = await getAllTransaction();
    list.sort((first, second) => second.date.compareTo(first.date));
    transactionList.clear();
    transactionList.addAll(list);
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    notifyListeners();
  }

  Future<void> editTransaction(TranscationModel model) async {
    final db = await Hive.openBox<TranscationModel>('transactions');
    await db.put(model.id, model);
    refresh();
  }

  Future<List<TranscationModel>> getAllTransaction() async {
    final db = await Hive.openBox<TranscationModel>('transactions');
    return db.values.toList();
  }

  Future<List<TranscationModel>> accessTransactions() async {
    final db = await Hive.openBox<TranscationModel>('transactions');
    return db.values.toList();
  }

  Future<void> deletTransaction(String id) async {
    final db = await Hive.openBox<TranscationModel>('transactions');
    await db.delete(id);
    refresh();
    notifyListeners();
  }

  Future<void> search(String text) async {
    final db = await Hive.openBox<TranscationModel>('transactions');
    List<TranscationModel>? filteredList;

    if (selectedCatogory == 'Income') {
      filteredList = db.values
          .where((element) =>
              element.type == CategoryType.income &&
              element.category.name
                  .toLowerCase()
                  .trim()
                  .contains(text.toLowerCase()))
          .toList();
    } else if (selectedCatogory == 'Expense') {
      filteredList = db.values
          .where((element) =>
              element.type == CategoryType.expense &&
              element.category.name
                  .toLowerCase()
                  .trim()
                  .contains(text.toLowerCase()))
          .toList();
    } else if (selectedCatogory == "All") {
      filteredList = db.values
          .where((element) => element.category.name
              .toLowerCase()
              .trim()
              .contains(text.toLowerCase()))
          .toList();
    } else {
      filteredList = db.values
          .where((element) => element.category.name
              .toLowerCase()
              .trim()
              .contains(text.toLowerCase()))
          .toList();
    }
    transactionList.clear();
    transactionList.addAll(filteredList);
    notifyListeners();
  }

  Future<void> filterDataByDate(String dateRange) async {
    // ignore: non_constant_identifier_names
    final TransactionDb = await Hive.openBox<TranscationModel>('transactions');
    List<TranscationModel> dateFilterList = [];
    if (dateRange == 'today') {
      if (selectedCatogory == "Income") {
        dateFilterList = TransactionDb.values
            .where((element) =>
                element.type == CategoryType.income &&
                element.date.day == DateTime.now().day &&
                element.date.month == DateTime.now().month &&
                element.date.year == DateTime.now().year)
            .toList();
      } else if (selectedCatogory == "Expense") {
        dateFilterList = TransactionDb.values
            .where((element) =>
                element.type == CategoryType.expense &&
                element.date.day == DateTime.now().day &&
                element.date.month == DateTime.now().month &&
                element.date.year == DateTime.now().year)
            .toList();
      } else {
        dateFilterList = TransactionDb.values
            .where((element) =>
                element.date.day == DateTime.now().day &&
                element.date.month == DateTime.now().month &&
                element.date.year == DateTime.now().year)
            .toList();
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        notifyListeners();
      }
    } else if (dateRange == 'yesterday') {
      if (selectedCatogory == "Income") {
        dateFilterList = TransactionDb.values
            .where((element) =>
                element.type == CategoryType.income &&
                element.date.day == DateTime.now().day - 1 &&
                element.date.month == DateTime.now().month &&
                element.date.year == DateTime.now().year)
            .toList();
      } else if (selectedCatogory == "Expense") {
        dateFilterList = TransactionDb.values
            .where((element) =>
                element.type == CategoryType.expense &&
                element.date.day == DateTime.now().day - 1 &&
                element.date.month == DateTime.now().month &&
                element.date.year == DateTime.now().year)
            .toList();
      } else {
        dateFilterList = TransactionDb.values
            .where((element) =>
                element.date.day == DateTime.now().day - 1 &&
                element.date.month == DateTime.now().month &&
                element.date.year == DateTime.now().year)
            .toList();
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        notifyListeners();
      }
    } else if (dateRange == 'last week') {
      final DateTime today = DateTime.now();
      final DateTime weekAgo = today.subtract(const Duration(days: 7));

      if (selectedCatogory == "Income") {
        dateFilterList = TransactionDb.values
            .where((element) =>
                element.type == CategoryType.income &&
                element.date.isAfter(weekAgo) &&
                element.date.isBefore(today))
            .toList();
      } else if (selectedCatogory == "Expense") {
        dateFilterList = TransactionDb.values
            .where((element) =>
                element.type == CategoryType.expense &&
                element.date.isAfter(weekAgo) &&
                element.date.isBefore(today))
            .toList();
      } else {
        dateFilterList = TransactionDb.values
            .where((element) =>
                element.date.isAfter(weekAgo) && element.date.isBefore(today))
            .toList();
      }
    } else if (dateRange == 'all') {
      refresh();
    } else {
      TransactionDb.values.toList();
    }
    transactionList.clear();
    transactionList.addAll(dateFilterList);
    notifyListeners();
  }

  Future<void> filter(String text) async {
    if (text == 'Income') {
      final transactionDB =
          await Hive.openBox<TranscationModel>('transactions');
      transactionList.clear();
      transactionList.addAll(transactionDB.values
          .where((element) => element.type == CategoryType.income)
          .toList());
      selectedCatogory = "Income";
      notifyListeners();
    } else if (text == 'Expense') {
      final transactionDB =
          await Hive.openBox<TranscationModel>('transactions');
      transactionList.clear();
      transactionList.addAll(transactionDB.values
          .where((element) => element.type == CategoryType.expense)
          .toList());
      selectedCatogory = "Expense";
      notifyListeners();
    } else if (text == "All") {
      selectedCatogory = "All";
      refresh();
      notifyListeners();
    }
  }

  ValueNotifier<double> incomenotifier = ValueNotifier(0);
  ValueNotifier<double> expensenotifier = ValueNotifier(0);
  ValueNotifier<double> totalnotifier = ValueNotifier(0);

  Future<void> balanceAmount() async {
    await getAllTransaction().then((value) {
      incomenotifier.value = 0;
      expensenotifier.value = 0;
      totalnotifier.value = 0;

      for (var item in value) {
        if (item.type == CategoryType.income) {
          incomenotifier.value += item.amount;
        } else {
          expensenotifier.value += item.amount;
        }
      }
      totalnotifier.value = incomenotifier.value - expensenotifier.value;
    });
    notifyListeners();
  }
}

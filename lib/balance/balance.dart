// import 'package:flutter/widgets.dart';
// import 'package:stash_project/db/transaction/transaction_db.dart';
// import 'package:stash_project/models/category/category_model.dart';

// ValueNotifier<double> incomenotifier = ValueNotifier(0);
// ValueNotifier<double> expensenotifier = ValueNotifier(0);
// ValueNotifier<double> totalnotifier = ValueNotifier(0);

// Future<void> balanceAmount() async {
//   await TransactionDb.instance.getAllTransaction().then((value) {
//     incomenotifier.value = 0;
//     expensenotifier.value = 0;
//     totalnotifier.value = 0;

//     for (var item in value) {
//       if (item.type == CategoryType.income) {
//         incomenotifier.value += item.amount;
//       } else {
//         expensenotifier.value += item.amount;
//       }
//     }
//     totalnotifier.value = incomenotifier.value - expensenotifier.value;
//   });
// }

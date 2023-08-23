import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stash_project/db/profile/profile_db.dart';
import 'package:stash_project/models/category/category_model.dart';
import 'package:stash_project/models/transaction/transaction_model.dart';
import 'package:stash_project/provider.dart/transaction_provider.dart';
import 'package:stash_project/screens/pages/welcome-screens/welcomescreen1.dart';

void showAlertreset(BuildContext context) {
  showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text(
            'Reset App',
            style: TextStyle(color: Color.fromARGB(255, 228, 15, 15)),
          ),
          content: const Text(
              'All the related datas will be cleared from the database'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text("No")),
            Consumer<TransactionProvider>(
              builder: (context,transactionProvider,child) {
                return TextButton(
                    onPressed: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      await preferences.clear();
                      SharedPreferences textcontrol =
                          await SharedPreferences.getInstance();
                      await textcontrol.clear();
                      final transactionDb =
                          await Hive.openBox<TranscationModel>('transactions');
                      final categoryDb =
                          await Hive.openBox<CategoryModel>('category');
                      
                      categoryDb.clear();
                      transactionDb.clear();
                      userdata = null;

                       transactionProvider. incomenotifier = ValueNotifier(0);
                      transactionProvider.expensenotifier = ValueNotifier(0);
                      transactionProvider.totalnotifier = ValueNotifier(0);

                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const WelcomeScreen()));
                    },
                    child: const Text("Yes"));
              }
            )
          ],
        );
      });
}

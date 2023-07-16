import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stash_project/balance/balance.dart';
import 'package:stash_project/db/category/category_db.dart';
import 'package:stash_project/db/profile/profile_db.dart';
import 'package:stash_project/db/transaction/transaction_db.dart';
import 'package:stash_project/models/category/category_model.dart';
import 'package:stash_project/models/profile/profile_model.dart';
import 'package:stash_project/models/transaction/transaction_model.dart';
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
            TextButton(
                onPressed: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  await preferences.clear();
                  SharedPreferences textcontrol =
                      await SharedPreferences.getInstance();
                  await textcontrol.clear();
                  final transactionDb =
                      await Hive.openBox<TranscationModel>(TRANSACTION_DB_NAME);
                  final categoryDb =
                      await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
                  final profiledb =
                      await Hive.openBox<ProfileModel>('profile_Db');
                  categoryDb.clear();
                  transactionDb.clear();
                  profiledb.clear();
                  userdata = null;

                  incomenotifier = ValueNotifier(0);
                  expensenotifier = ValueNotifier(0);
                  totalnotifier = ValueNotifier(0);

                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const WelcomeScreen()));
                },
                child: const Text("Yes"))
          ],
        );
      });
}

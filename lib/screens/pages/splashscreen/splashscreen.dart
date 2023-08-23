import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stash_project/db/category/category_db.dart';
import 'package:stash_project/db/transaction/transaction_db.dart';

import '../../../core/constants.dart';
import '../../../provider.dart/category_provider.dart';
import '../../../provider.dart/transaction_provider.dart';
import '../bottom-nav/bottomnav.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // CategoryDB.instance.refreshUI();
    // TransactionDb.instance.refresh();
      Provider.of<TransactionProvider>(context, listen: false).refresh();
 Provider.of<CategoryProvider>(context, listen: false).refreshUI();
    Timer(
        const Duration(seconds: 2),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const BottomNavScreen())));
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'STASH',
              style: TextStyle(
                  color: Color.fromARGB(255, 237, 232, 232),
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            Divider(
              color: Colors.white,
              thickness: 2,
              indent: 150,
              endIndent: 150,
            ),
            Text(
              'Save your Money',
              style: TextStyle(
                  color: Color.fromARGB(255, 237, 232, 232), fontSize: 10),
            )
          ],
        ),
      ),
    );
  }
}

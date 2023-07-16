import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stash_project/screens/pages/splashscreen/splashscreen.dart';
import 'package:stash_project/screens/pages/welcome-screens/welcomemessage2.dart';
import '../../../db/category/category_db.dart';
import '../../../db/transaction/transaction_db.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _hasSeenwelcomescreen = false;

  @override
  void initState() {
    super.initState();
    checkIfSeenWelcomescreen();
  }

  void checkIfSeenWelcomescreen() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    bool hasSeenwelcomescreen =
        preference.getBool('hasSeenwelcomescreen') ?? false;
    setState(() {
      _hasSeenwelcomescreen = hasSeenwelcomescreen;
    });
  }

  void setHasSeenWelcomeScreen() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('hasSeenwelcomescreen', true);
  }

  @override
  Widget build(BuildContext context) {
    TransactionDb.instance.refresh();
    CategoryDB.instance.refreshUI();
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 280, top: 10),
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SplashScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple[800]),
                      icon: const Icon(
                        Icons.skip_next,
                      ),
                      label: const Text("Skip"),
                      //.........
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 200),
                child: Column(
                  children: [
                    Text(
                      'Never Spend\nYour\nMoney\nBefore\nYou Have it',
                      style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple[800]),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 275, top: 160),
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        setHasSeenWelcomeScreen();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const WelcomeScreen2()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 166, 165, 240),
                      ),
                      icon: const Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.black,
                      ),
                      label: const Text(
                        'Next',
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

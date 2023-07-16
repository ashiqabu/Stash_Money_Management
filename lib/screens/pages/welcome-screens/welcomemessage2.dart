import 'package:flutter/material.dart';
import 'package:stash_project/screens/pages/splashscreen/splashscreen.dart';

class WelcomeScreen2 extends StatelessWidget {
  const WelcomeScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 65, top: 200),
                child: Column(
                  children: [
                    Text(
                      'Save Your Money\nAnd\nTime\nThrough\nSTASH',
                      style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple[800]),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 230, top: 160),
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SplashScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 166, 165, 240)),
                      icon: const Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.black,
                      ),
                      label: const Text(
                        'Get Start',
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

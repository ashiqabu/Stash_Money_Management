import 'package:flutter/material.dart';
import 'package:stash_project/core/constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('About Us'),
          centerTitle: true,
          backgroundColor: mainColor),
      body: Padding(
        padding: const EdgeInsets.all(80.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'STASH',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "    Developed by\nMohammed Ashik",
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Version 1.0.2',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

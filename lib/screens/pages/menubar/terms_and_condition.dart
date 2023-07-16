import 'package:flutter/material.dart';
import 'package:stash_project/core/constants.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: mainColor,
        centerTitle: true,
        title: Text(
          'Terms and Conditions',
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.06,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Welcome to our Money Management App.\n\nBy using this app, you agree to be bound by the following terms and conditions: \n\n1. General Disclaimer \n\nThe information provided in this app is for general informational purposes only and should not be considered as financial advice. We do not guarantee the accuracy, completeness, or timeliness of the information provided. Users of this app should consult with a financial professional before making any financial decisions. \n\n2. Use of the App \n\nYou agree to use this app only for lawful purposes and in accordance with these terms and conditions. You agree not to use this app in any way that could damage or impair the app's functionality or interfere with other users' use of the app. \n\n3. Privacy Policy \n\nWe respect your privacy and are committed to protecting your personal information. Please review our Privacy Policy for more information on how we collect, use, and protect your information. \n\n4. Intellectual Property  \n\nAll content and materials included in this app, including text, graphics, logos, icons, images, and software, are the property of our company or its licensors and are protected by applicable copyright and trademark laws. \n\n4. Limitation of Liability \n\nIn no event shall our company, its affiliates, or its licensors be liable for any damages, including without limitation, direct, indirect, incidental, special, or consequential damages, arising out of or in connection with the use of this app. \n\n5. Changes to the Terms and Conditions \n\nWe reserve the right to modify or revise these terms and conditions at any time. By continuing to use this app after such changes, you agree to be bound by the modified or revised terms and conditions. \n\n5. Governing Law \n\nThese terms and conditions shall be governed by and construed in accordance with the laws of the state where our company is headquartered, without giving effect to any principles of conflicts of law.\n\nIf you do not agree to these terms and conditions, you should not use this app.",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.055),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

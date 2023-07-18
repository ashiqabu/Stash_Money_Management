import 'package:flutter/material.dart';
import 'package:stash_project/core/constants.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Privacy Policy',
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.06,
              color: Colors.white,
              fontWeight: FontWeight.w600),
        ),
        toolbarHeight: 70,
        elevation: 1,
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(
              "This Privacy Policy describes how we collect, use, and protect your personal information when you use our money management application('Stash') \n\n Information We Collect  \n\n1 .We collect the following types of information when you use the Application :  To personalize the user experience, such as customizing spending categories or recommending budget goals To analyze spending patterns, such as identifying areas where users could save money To share data with third-party service providers, such as payment processors or data analytics companies \n\n2 .How We Protect Your Information We take the following measures to protect your personal information :   We encrypt user data in transit and at rest We use secure authentication protocols, such as two-factor authentication \n\n3 .We regularly perform security updates and vulnerability testing Your Rights and Choices You have the following rights and choices regarding your personal information :  You can delete or modify your user data at any time You can opt-in or opt-out of data sharing or marketing communications You can contact us with any questions or concerns about our privacy practices Updates to this Privacy Policy We may update this Privacy Policy from time to time. \n\nIf we make any material changes, we will notify you by email or through the Application. If you have any questions or concerns about this Privacy Policy, please contact us at support@stash.com. ",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.055,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

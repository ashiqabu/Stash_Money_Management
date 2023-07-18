import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stash_project/core/constants.dart';
import 'package:stash_project/db/profile/profile_db.dart';
import 'package:stash_project/screens/pages/menubar/addprofile.dart';
import 'package:stash_project/screens/pages/menubar/privacy_policy.dart';
import 'package:stash_project/screens/pages/menubar/reset.dart';
import 'package:stash_project/screens/pages/menubar/terms_and_condition.dart';

import 'about.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    getprofile();
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
      ),
      child: ListView(padding: EdgeInsets.zero, children: [
        ValueListenableBuilder(
          valueListenable: profilelistnotifier,
          builder: (context, value, _) => UserAccountsDrawerHeader(
            accountName: Text(userdata?.name ?? 'Name'),
            accountEmail: Text(userdata?.email ?? 'Example@email.com'),
            currentAccountPicture: CircleAvatar(
              child: userdata?.image == null
                  ? ClipOval(
                      child: Image.asset(
                        'assets/nature.jpg',
                        alignment: Alignment.center,
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    )
                  : ClipOval(
                      child: Image.file(
                        File(userdata!.image),
                        alignment: Alignment.center,
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            decoration: const BoxDecoration(
              color: mainColor,
            ),
          ),
        ),
        ListTile(
            leading: const Icon(
              Icons.info,
              color: mainColor,
            ),
            title: const Text(
              'About',
              style: TextStyle(fontSize: 15),
            ),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AboutScreen()))),
        ListTile(
          leading: const Icon(
            Icons.reset_tv,
            color: mainColor,
          ),
          title: const Text(
            'Reset',
            style: TextStyle(fontSize: 15),
          ),
          // ignore: avoid_returning_null_for_void
          onTap: () => showAlertreset(context),
        ),
        ListTile(
          leading: const Icon(
            Icons.list,
            color: mainColor,
          ),
          title: const Text(
            'Terms And Condition',
            style: TextStyle(fontSize: 15),
          ),
          // ignore: avoid_returning_null_for_void
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const TermsAndConditions())),
        ),
        ListTile(
          leading: const Icon(
            Icons.privacy_tip
            ,
            color: mainColor,
          ),
          title: const Text(
            'Privacy Policy',
            style: TextStyle(fontSize: 15),
          ),
          // ignore: avoid_returning_null_for_void
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const PrivacyPolicy())),
        ),
        ListTile(
          leading: const Icon(
            Icons.add_a_photo,
            color: mainColor,
          ),
          title: ValueListenableBuilder(
            valueListenable: profilelistnotifier,
            builder: (context, value, child) => Text(
              userdata?.name == null ? 'Add Profile' : 'Update Profile',
              style: const TextStyle(fontSize: 15),
            ),
          ),
          // ignore: avoid_returning_null_for_void
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddProfile())),
        )
      ]),
    );
  }
}

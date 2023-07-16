import 'package:flutter/material.dart';
import 'package:stash_project/screens/pages/bottom-nav/homescreen.dart';
import 'package:stash_project/screens/pages/bottom-nav/insights.dart';
import 'package:stash_project/screens/pages/transactions/addtransaction.dart';
import '../../../core/constants.dart';
import '../../category/addcategorypop_up.dart';
import 'category.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int currentIndex = 0;

  List<Widget> widgetlist = [
    const HomeScreen(),
    const CategoryScreen(),
    const FinancialReport()
  ];

  get texteditcntrl => null;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Exit App'),
                content: const Text('Do you want to Exit'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('No')),
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('yes'))
                ],
              );
            });
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
        body: widgetlist[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: mainColor,
          unselectedItemColor: Colors.white,
          fixedColor: const Color.fromARGB(255, 166, 165, 240),
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.white), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.category,
                  color: Colors.white,
                ),
                label: 'Category'),
            BottomNavigationBarItem(
                icon: Icon(Icons.insights, color: Colors.white),
                label: 'Insights'),
          ],
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          iconSize: 30,
        ),
        floatingActionButton: Visibility(
          visible: currentIndex != 2 ? true : false,
          child: FloatingActionButton(
            onPressed: () {
              if (currentIndex == 0) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const AddTransaction();
                  },
                ));
              } else {
                categoryTypePopUp(context, texteditcntrl);
              }
            },
            backgroundColor:mainColor,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

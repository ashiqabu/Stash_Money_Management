import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stash_project/provider.dart/category_provider.dart';
import '../../category/expense.dart';
import '../../category/income.dart';
import '../menubar/menu.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  get texteditcntrl => null;

  @override
  void initState() {
    //CategoryDB().refreshUI();
    super.initState();
    Provider.of<CategoryProvider>(context, listen: false).refreshUI();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: const MenuScreen(),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(225, 53, 9, 85),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Income',
              ),
              Tab(
                text: 'Expense',
              )
            ],
            indicatorColor: Color.fromARGB(255, 166, 165, 240),
          ),
          title: const Text('Category'),
          centerTitle: true,
        ),
        body: const TabBarView(children: [
          IncomeScreen(),
          ExpenseScreen(),
        ]),
      ),
    );
  }
}

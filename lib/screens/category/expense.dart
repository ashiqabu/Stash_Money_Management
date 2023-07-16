import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:stash_project/db/category/category_db.dart';
import '../../models/category/category_model.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  bool check1 = false;

  bool transactionCancellDelation = false;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDB().expanseCAtegoryListListener,
        builder: (BuildContext ctx, List<CategoryModel> newList, Widget? _) {
          return newList.isNotEmpty
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: newList.length > 700 ? 6 : 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      mainAxisExtent: 120),
                  itemBuilder: (ctx, index) {
                    final category = newList[index];
                    return Card(
                      elevation: 40,
                      shadowColor: Colors.black,
                      margin: const EdgeInsets.all(15),
                      color: const Color.fromARGB(255, 166, 165, 240),
                      child: ListTile(
                        title: Text(category.name),
                        trailing: IconButton(
                            onPressed: () {
                              showAlert(context, index);
                            },
                            icon: const Icon(Icons.close)),
                      ),
                    );
                  },
                  itemCount: newList.length)
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "  No transactions yet !",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
        });
  }

  void showAlert(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (ctx) {
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              title: Text(
                'Do you want to delete ${CategoryDB().expanseCAtegoryListListener.value[index].name}',
                style: const TextStyle(color: Color.fromARGB(255, 228, 15, 15)),
              ),
              content: Row(
                children: const [
                  Expanded(
                    flex: 4,
                    child: SizedBox(
                      child: Text(
                        'All the related datas will be cleared from the database',
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: const Text("No")),
                TextButton(
                    onPressed: () {
                      CategoryDB.instance.deleteCategory(CategoryDB()
                          .expanseCAtegoryListListener
                          .value[index]
                          .id);
                      Navigator.of(ctx).pop();
                    },
                    child: const Text("Yes"))
              ],
            ),
          );
        });
  }
}

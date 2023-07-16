import 'package:flutter/material.dart';
import '../../db/category/category_db.dart';
import '../../models/category/category_model.dart';

class IncomeScreen extends StatelessWidget {
  const IncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDB().incomeCAtegoryListListener,
        builder: (BuildContext ctx, List<CategoryModel> newList, Widget? _) {
          return newList.isNotEmpty
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: newList.length > 300 ? 3 : 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      mainAxisExtent: 120),
                  itemBuilder: (ctx, index) {
                    final category = newList[index];
                    return Card(
                      margin: const EdgeInsets.all(15),
                      elevation: 40,
                      shadowColor: Colors.black,
                      color: const Color.fromARGB(255, 166, 165, 240),
                      child: ListTile(
                        title: Text(
                          category.name,
                          style: const TextStyle(fontSize: 15),
                        ),
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
          return AlertDialog(
            title: Text(
              'Do you want to delete ${CategoryDB().incomeCAtegoryListListener.value[index].name}',
              style: const TextStyle(color: Color.fromARGB(255, 228, 15, 15)),
            ),
            content: const Text(
                'All the related datas will be cleared from the database'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text("No")),
              TextButton(
                  onPressed: () {
                    CategoryDB.instance.deleteCategory(CategoryDB()
                        .incomeCAtegoryListListener
                        .value[index]
                        .id);
                    Navigator.of(ctx).pop();
                  },
                  child: const Text("Yes"))
            ],
          );
        });
  }
}

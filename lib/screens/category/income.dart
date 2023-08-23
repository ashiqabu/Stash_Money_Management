import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stash_project/models/category/category_model.dart';
import '../../provider.dart/category_provider.dart';

class IncomeScreen extends StatelessWidget {
  const IncomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, _) {
        return categoryProvider.incomeCategoryList.isNotEmpty
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  mainAxisExtent: 100,
                ),
                itemBuilder: (ctx, index) {
                  final category = categoryProvider.incomeCategoryList[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Card(
                      elevation: 8,
                      shadowColor: Colors.black,
                      color: const Color.fromARGB(255, 166, 165, 240),
                      child: ListTile(
                        title: Text(
                          category.name,
                          style: const TextStyle(fontSize: 15),
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            _showAlert(context, category);
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: categoryProvider.incomeCategoryList.length,
              )
            : const Center(
                child: Text(
                  "No transactions yet!",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              );
      },
    );
  }

  void _showAlert(BuildContext context, CategoryModel category) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(
            'Do you want to delete ${category.name}?',
            style: const TextStyle(color: Color.fromARGB(255, 228, 15, 15)),
          ),
          content: const Text(
              'All the related data will be cleared from the database'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                Provider.of<CategoryProvider>(context, listen: false)
                    .deleteCategorys(category.id);
                Navigator.of(ctx).pop();
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }
}

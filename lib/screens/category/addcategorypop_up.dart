import 'package:flutter/material.dart';
import 'package:stash_project/db/category/category_db.dart';
import 'package:stash_project/models/category/category_model.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

Future<void> categoryTypePopUp(BuildContext context, type) async {
  final formKey = GlobalKey<FormState>();
  final nameEditingController = TextEditingController();

  showDialog(
    context: context,
    builder: (ctx) {
      return Form(
        key: formKey,
        child: SimpleDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          title: const Center(child: Text('Add Category')),
          children: [
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: TextFormField(
                controller: nameEditingController,
                decoration: const InputDecoration(
                  hintText: 'Category Name',
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(225, 53, 9, 85),
                    ),
                  ),
                ),
                validator: (value) {
                  if (nameEditingController.text.isEmpty || value == null) {
                    return 'Category Field is Empty';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(children: const [
                RadioButton(title: 'Income', type: CategoryType.income),
                RadioButton(title: 'Expanse', type: CategoryType.expense),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 1,
                      backgroundColor: const Color.fromARGB(225, 53, 9, 85)),
                  onPressed: () {
                    final name = nameEditingController.text;

                    if (formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            duration: Duration(seconds: 2),
                            elevation: 2,
                            behavior: SnackBarBehavior.floating,
                            padding: EdgeInsets.all(15),
                            backgroundColor: Colors.green,
                            content: Text(
                              'Adding Successfully',
                              style: TextStyle(color: Colors.white),
                            )),
                      );
                    }
                    if (name.isEmpty) {
                      return;
                    }
                    final type = selectedCategoryNotifier.value;
                    final category = CategoryModel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        name: name,
                        type: type);

                    CategoryDB.instance.insertCategory(category);

                    Navigator.of(ctx).pop();
                  },
                  child: const Text(
                    'Add',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({super.key, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedCategoryNotifier,
            builder: (BuildContext ctx, CategoryType newCategory, Widget? _) {
              return Radio<CategoryType>(
                  activeColor: const Color.fromARGB(225, 53, 9, 85),
                  value: type,
                  groupValue: selectedCategoryNotifier.value,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    selectedCategoryNotifier.value = value;
                    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                    selectedCategoryNotifier.notifyListeners();
                  });
            }),
        Text(title)
      ],
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stash_project/core/constants.dart';
import 'package:stash_project/models/category/category_model.dart';
import 'package:stash_project/models/transaction/transaction_model.dart';
import 'package:stash_project/provider.dart/addtransaction_provider.dart';
import 'package:stash_project/provider.dart/category_provider.dart';
import 'package:stash_project/provider.dart/transaction_provider.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  DateTime? _selectedDate;
  // CategoryType? _selectedCategorytype;
  CategoryModel? _selectedCategoryModel;

  // String? _categoryID;

  final _formkey = GlobalKey<FormState>();

  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();

  @override
  void initState() {
    context.read<CategoryProvider>().refreshUI();
    // selectedCategorytype = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddTransactionsProvider(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: mainColor,
          title: const Text(
            'Add Transaction',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Consumer<AddTransactionsProvider>(
          builder: (context, provider, _) {
           
            return Form(
              key: _formkey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                provider.updateCategoryId(null);
                                provider.updateSelectedCategoryType(
                                    CategoryType.income);
                              },
                              child: Row(
                                children: [
                                  Radio(
                                      value: CategoryType.income,
                                      groupValue: provider.selectedCategorytype,
                                      activeColor: mainColor,
                                      onChanged: (newValue) {}),
                                  const Text(
                                    'Income',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            GestureDetector(
                              onTap: () {
                                provider.updateCategoryId(null);
                                provider.updateSelectedCategoryType(
                                    CategoryType.expense);
                              },
                              child: Row(
                                children: [
                                  Radio(
                                      value: CategoryType.expense,
                                      groupValue: provider.selectedCategorytype,
                                      activeColor: mainColor,
                                      onChanged: (newValue) {}),
                                  const Text(
                                    'Expense',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: const [
                            Text(
                              'Category',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.075,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(7)),
                          child: Center(
                            child: DropdownButton<String>(
                              underline: Container(),
                              hint: const Text(
                                'Select Category',
                                style: TextStyle(color: Colors.black),
                              ),
                              value: provider.categoryID,
                              items: (provider.selectedCategorytype ==
                                          CategoryType.income
                                      ? context
                                          .read<CategoryProvider>()
                                          .incomeCategoryList
                                      : context
                                          .read<CategoryProvider>()
                                          .expenseCategoryList)
                                  .map((e) {
                                return DropdownMenuItem(
                                  value: e.id,
                                  child: Text(
                                    e.name,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  onTap: () {
                                    // print(e.toString());
                                    provider.selectedCategoryModel = e;
                                  },
                                );
                              }).toList(),
                              onChanged: (selectedValue) {
                                // print(selectedValue);
                                // setState(() {
                                //   _categoryID = selectedValue;
                                // });
                                provider.updateCategoryId(selectedValue);
                                log(selectedValue.toString());
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: const [
                            Text(
                              'Description',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextFormField(
                            controller: _purposeTextEditingController,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                            decoration: const InputDecoration(
                              fillColor: Colors.white,
                              hintText: 'Description',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: const [
                            Text(
                              'Amount',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextFormField(
                            controller: _amountTextEditingController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                            decoration: const InputDecoration(
                              hintText: 'Amount',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: const [
                            Text(
                              'Date',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.075,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme:
                                  Theme.of(context).colorScheme.copyWith(
                                        primary: Colors.black,
                                      ),
                            ),
                            child: TextButton.icon(
                              onPressed: () async {
                                final selectedDateTemp = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now()
                                      .subtract(const Duration(days: 30)),
                                  lastDate: DateTime.now(),
                                );

                                if (selectedDateTemp == null) {
                                  return;
                                } else {
                                  // print(_selectedDate.toString());
                                  provider.updateSelectedDate(selectedDateTemp);
                                }
                              },
                              icon: const Icon(
                                Icons.calendar_month,
                                color: Colors.black,
                              ),
                              label: Text(
                                provider.selectedDate == null
                                    ? 'Select Date'
                                    : DateFormat("dd-MMMM-yyyy")
                                        .format(provider.selectedDate!),
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Center(
                          child: SizedBox(
                            width: 100,
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                backgroundColor: mainColor,
                              ),
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  addTransaction(
                                      provider.selectedCategorytype,
                                      provider.selectedDate,
                                      provider.selectedCategoryModel,
                                      provider.categoryID);
                                }
                              },
                              child: const Text(
                                'Submit',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        )
                      ]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<void> addTransaction(CategoryType Ctype, DateTime? selectedDate,
      CategoryModel? selectedCategoryModel, String? categoryID) async {
    final purposeText = _purposeTextEditingController.text.trim();
    final amountText = _amountTextEditingController.text.trim();
    if (purposeText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please add the Description fields!"),
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(10),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        closeIconColor: Colors.white,
        duration: Duration(seconds: 2),
      ));
    }
    if (amountText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please add the Amount fields!"),
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(10),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        closeIconColor: Colors.white,
        duration: Duration(seconds: 2),
      ));
    }
    if (categoryID == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please add the Category fields!"),
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(10),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        closeIconColor: Colors.white,
        duration: Duration(seconds: 2),
      ));
    }
    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please add the Date fields!"),
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(10),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        closeIconColor: Colors.white,
        duration: Duration(seconds: 2),
      ));
    }

    if (selectedCategoryModel == null) {
      return;
    }

    final parsedAmount = double.tryParse(amountText);
    if (parsedAmount == null) {
      return;
    }

    final model = TranscationModel(
      note: purposeText,
      amount: parsedAmount,
      date: selectedDate!,
      type: Ctype,
      category: selectedCategoryModel,
       id: DateTime.now().millisecondsSinceEpoch.toString(),
    );

    await context.read<TransactionProvider>().addTransaction(model);
    // ignore: use_build_context_synchronously
    context.read<TransactionProvider>().refresh();
    // ignore: use_build_context_synchronously
    context.read<TransactionProvider>().balanceAmount();

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Data Added SuccessFully"),
      backgroundColor: Colors.green,
      margin: EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: Duration(seconds: 2),
    ));
    Navigator.of(context).pop();
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:stash_project/balance/balance.dart';
import 'package:stash_project/core/constants.dart';
import 'package:stash_project/db/category/category_db.dart';
import 'package:stash_project/db/chart/chart_db.dart';
import 'package:stash_project/db/transaction/transaction_db.dart';
import 'package:stash_project/models/category/category_model.dart';
import 'package:stash_project/models/transaction/transaction_model.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  int? value = 1;
  final noteEditcntrl = TextEditingController();
  final amountEditingcntrl = TextEditingController();
  final formkey = GlobalKey<FormState>();
  DateTime? selectedDate;
  CategoryType? selectedCategoryType;
  CategoryModel? selectedcategoryModel;
  String? _categoryID;

  @override
  void initState() {
    selectedCategoryType = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CategoryDB.instance.refreshUI();
    TransactionDb.instance.refresh();
    filterFunction();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text('Add Transaction'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          Radio(
                              activeColor: mainColor,
                              value: CategoryType.income,
                              groupValue: selectedCategoryType,
                              onChanged: (newvalue) {
                                setState(() {
                                  selectedCategoryType = CategoryType.income;
                                  _categoryID = null;
                                });
                              }),
                          const Text('Income'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              activeColor: mainColor,
                              value: CategoryType.expense,
                              groupValue: selectedCategoryType,
                              onChanged: (newvalue) {
                                setState(() {
                                  selectedCategoryType = CategoryType.expense;
                                  _categoryID = null;
                                });
                              }),
                          const Text('Expense'),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Row(
                      children: const [
                        Text(
                          'Category',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        child: Container(
                          width: 325.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(3)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton<String>(
                              underline: Container(),
                              hint: const Text('Select Category'),
                              value: _categoryID,
                              items: (selectedCategoryType ==
                                          CategoryType.income
                                      ? CategoryDB().incomeCAtegoryListListener
                                      : CategoryDB()
                                          .expanseCAtegoryListListener)
                                  .value
                                  .map((e) {
                                return DropdownMenuItem(
                                  value: e.id,
                                  child: Text(
                                    e.name,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  onTap: () {
                                    selectedcategoryModel = e;
                                  },
                                );
                              }).toList(),
                              onChanged: (selectedValue) {
                                setState(() {
                                  _categoryID = selectedValue;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                child: Row(
                  children: const [
                    Text(
                      'Amount',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: amountEditingcntrl,
                  maxLength: 10,
                  decoration: InputDecoration(
                      hintText: 'Enter The Amount',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                          onPressed: () {
                            amountEditingcntrl.clear();
                          },
                          icon: const Icon(Icons.clear))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 0, right: 20),
                child: Row(
                  children: const [
                    Text(
                      'Date',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  width: 325.w,
                  height: 50.h,
                  child: TextButton.icon(
                      onPressed: () async {
                        final selectedDatetemp = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 30)),
                            lastDate: DateTime.now());

                        if (selectedDatetemp == null) {
                          return;
                        } else {
                          stdout.write(selectedDatetemp.toString());
                          setState(() {
                            selectedDate = selectedDatetemp;
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.calendar_month,
                        color: Colors.black,
                      ),
                      label: Text(
                        selectedDate == null
                            ? 'Select Date'
                            : DateFormat("dd-MMMM-yyyy").format(selectedDate!),
                        style: const TextStyle(color: Colors.black),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Row(
                  children: const [
                    Text(
                      'Notes',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                child: TextFormField(
                  controller: noteEditcntrl,
                  decoration: const InputDecoration(
                    hintText: 'Enter the purpose',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor, shadowColor: Colors.black),
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        addTransaction();
                      }
                    },
                    child: const Text(
                      'Submit',
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future addTransaction() async {
    final noteText = noteEditcntrl.text;
    final amount = amountEditingcntrl.text;
    if (noteText.isEmpty) {
      return addingFailed();
    }
    if (amount.isEmpty) {
      return addingFailed();
    }
    if (_categoryID == null) {
      return addingFailed();
    }
    if (selectedDate == null) {
      return addingFailed();
    }
    final parsedAmount = double.tryParse(amount);
    if (parsedAmount == null) {
      return addingFailed();
    }
    if (selectedcategoryModel == null) {
      return;
    }

    final model = TranscationModel(
        note: noteText.trim(),
        amount: parsedAmount,
        date: selectedDate!,
        type: selectedCategoryType!,
        category: selectedcategoryModel!);

    await TransactionDb.instance.addTransaction(model);
    // ignore: use_build_context_synchronously

    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
    TransactionDb.instance.refresh();
    balanceAmount();
    TransactionDb.instance.refresh();
    filterFunction();

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
  }

  void addingFailed() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Please add the remaining fields!"),
      backgroundColor: Colors.red,
      margin: EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: Duration(seconds: 2),
    ));
  }
}

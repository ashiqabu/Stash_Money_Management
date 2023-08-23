import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stash_project/core/constants.dart';
import '../../../models/category/category_model.dart';
import '../../../models/transaction/transaction_model.dart';
import '../../../provider.dart/category_provider.dart';
import '../../../provider.dart/edit_transaction_provider.dart';
import '../../../provider.dart/transaction_provider.dart';

class EditTransaction extends StatefulWidget {
  const EditTransaction(
      {super.key,
      required this.model,
      required int id,
      required TranscationModel data});
  final TranscationModel model;

  @override
  State<EditTransaction> createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
  DateTime? _selectedDate;
  CategoryType? selectedCategorytype;
  CategoryModel? selectedCategoryModel;

  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();

  @override
  void initState() {
    _purposeTextEditingController.text = widget.model.note;
    _amountTextEditingController.text = widget.model.amount.toString();
     _selectedDate = widget.model.date;
    selectedCategorytype = widget.model.type;
     selectedCategoryModel = widget.model.category;
   

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // log(widget.model.id.toString(),name: 'buildcon');
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: mainColor,
          title: const Text(
            'Edit Transaction',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Consumer<EditTransactionsProvider>(
          builder: (context, provider, _) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Radio(
                                  value: CategoryType.income,
                                  groupValue: provider.selectedCategorytype,
                                  activeColor: mainColor,
                                  onChanged: (newValue) {
                                    provider.updateSelectedCategoryType(
                                        CategoryType.income);
                                    provider.updateCategoryId(null);
                                    // log('hello');
                                  }),
                              const Text(
                                'Income',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: CategoryType.expense,
                                  groupValue: provider.selectedCategorytype,
                                  activeColor: mainColor,
                                  onChanged: (newValue) {
                                    provider.updateSelectedCategoryType(
                                        CategoryType.expense);
                                    provider.updateCategoryId(null);
                                  }),
                              const Text(
                                'Expense',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: const [
                          Text(
                            'Category',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.075,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset:const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint:  Text(
                                widget.model.category.name,
                              ),
                              value: provider.categoryID,
                              items: (provider.selectedCategorytype ==
                                          CategoryType.income
                                      ? context
                                          .watch<CategoryProvider>()
                                          .incomeCategoryList
                                      : context
                                          .watch<CategoryProvider>()
                                          .expenseCategoryList)
                                  .map((e) {
                                return DropdownMenuItem(
                                  value: e.id,
                                  child: Text(
                                    e.name,
                                    style:const TextStyle(color: Colors.black),
                                  ),
                                  onTap: () {
                                    provider.selectedCategoryModel = e;
                                  },
                                );
                              }).toList(),
                              onChanged: (selectedValue) async {
                                await provider.updateCategoryId(selectedValue);
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Text(
                            'Description',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          controller: _purposeTextEditingController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            hintText: 'Description',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
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
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          controller: _amountTextEditingController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(fontSize: 16),
                          decoration: const InputDecoration(
                            hintText: 'Amount',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
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
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.075,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: Theme.of(context).colorScheme.copyWith(
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
                                log(selectedDateTemp.toString());
                                _selectedDate = selectedDateTemp;
                                provider.updateSelectedDate(selectedDateTemp);
                              }
                            },
                            icon: const Icon(
                              Icons.calendar_month,
                              color: Colors.black,
                            ),
                            label: Text(
                              _selectedDate == null
                                  ? 'Select Date'
                                  : DateFormat("dd-MMMM-yyyy")
                                      .format(_selectedDate!),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Center(
                        child: Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: mainColor),
                          child: TextButton(
                            onPressed: () {
                              editTransaction(
                                provider.selectedCategorytype,
                                provider.selectedDate,
                                provider.selectedCategoryModel,
                                provider.categoryID,
                              );
                            },
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    ]),
              ),
            );
          },
        ));
  }

  // ignore: non_constant_identifier_names
  Future<void> editTransaction(CategoryType Ctype, DateTime? selectedDate,
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
      return;
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
      return;
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
      return;
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
      return;
    }

    if (selectedCategoryModel == null) {
      log('120');
      return;
    }

    final parsedAmount = double.tryParse(amountText);
    if (parsedAmount == null) {
      return;
    }
    // log(widget.model.id.toString(),name: 'hjuikjnj');

    final model = TranscationModel(
      note: purposeText,
      amount: parsedAmount,
      date: selectedDate,
      type: Ctype,
      category: selectedCategoryModel, 
      id: widget.model.id,
    );
    
    await context.read<TransactionProvider>().editTransaction(model);
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
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();

    
  }
}

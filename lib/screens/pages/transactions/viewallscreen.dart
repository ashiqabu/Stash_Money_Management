import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:stash_project/models/category/category_model.dart';
import 'package:stash_project/models/transaction/transaction_model.dart';
import 'package:stash_project/provider.dart/transaction_provider.dart';
import 'package:stash_project/screens/pages/transactions/edit_transaction.dart';
import '../../../core/constants.dart';
import '../../../provider.dart/category_provider.dart';
import '../../../provider.dart/chart_provider.dart';

class VeiwAllScreen extends StatefulWidget {
  const VeiwAllScreen({super.key, required this.transactions});
  final List<TranscationModel> transactions;
  @override
  State<VeiwAllScreen> createState() => _VeiwAllScreenState();
}

class _VeiwAllScreenState extends State<VeiwAllScreen> {
  TextEditingController searchController = TextEditingController();
  var clearcntrl = TextEditingController();
  ValueNotifier<bool> clearButtonNotifier = ValueNotifier<bool>(false);

  @override
  void dispose() {
    clearcntrl.dispose();
    clearButtonNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TransactionProvider>(context, listen: false).refresh();
    Provider.of<CategoryProvider>(context, listen: false).refreshUI();
    return Consumer<TransactionProvider>(
      builder: (context, transactionProviderClass, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: mainColor,
            title: const Text('All Transactions'),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    showPopupMenu1();
                  },
                  icon: const Icon(Icons.sort)),
              IconButton(
                  onPressed: () {
                    showPopupMenu();
                  },
                  icon: const Icon(Icons.calendar_month))
            ],
          ),
          body: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Consumer<TransactionProvider>(
                      builder: (context, value, child) {
                        return Card(
                          elevation: 9,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                TextField(
                                  controller: clearcntrl,
                                  onChanged: (value) {
                                    Provider.of<TransactionProvider>(context,
                                            listen: false)
                                        .search(value);

                                    if (value.isEmpty) {
                                      clearButtonNotifier.value = false;
                                      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                                      clearButtonNotifier.notifyListeners();
                                    } else {
                                      clearButtonNotifier.value = true;
                                      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                                      clearButtonNotifier.notifyListeners();
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    hintText: 'Search By Category Name..',
                                    border: InputBorder.none,
                                    icon: Icon(
                                      Icons.search,
                                      // color: textClr,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: clearButtonNotifier.value,
                                  child: IconButton(
                                    onPressed: () {
                                      clearcntrl.clear();
                                      setState(() {
                                        clearButtonNotifier.value = false;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.blue,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Expanded(
                  child: transactionProviderClass.transactionList.isNotEmpty
                      ? ListView.separated(
                          itemBuilder: (ctx, id) {
                            final value =
                                transactionProviderClass.transactionList[id];
                            return Slidable(
                              key: Key(value.id!),
                              endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (ctx) {
                                        value;
                                         showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title:const Text('Delete'),
                                                    content:const Text(
                                                        'Are you sure?Do you want to delete this transaction?'),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child:
                                                             const Text('Cancel')),
                                                      TextButton(
                                                          onPressed: () {
                                                            context
                                                                .read<
                                                                    TransactionProvider>()
                                                                .deletTransaction(
                                                                    value.id!);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child:const Text('Ok'))
                                                    ],
                                                  );
                                                });
                                      },
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                    SlidableAction(
                                      onPressed: (ctx) {
                                        Provider.of<CategoryProvider>(context,
                                                listen: false)
                                            .refreshUI();
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditTransaction(
                                                      data: value,
                                                      id: id, model: value,
                                                    )));
                                      },
                                      icon: Icons.edit,
                                      label: 'Edit',
                                    )
                                  ]),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Card(
                                  shadowColor:
                                      const Color.fromARGB(255, 48, 48, 47),
                                  elevation: 1,
                                  child: ListTile(
                                    shape: const StadiumBorder(),
                                    leading: value.type == CategoryType.income
                                        ? const Icon(
                                            Icons.arrow_upward,
                                            color: Colors.green,
                                          )
                                        : const Icon(
                                            Icons.arrow_downward,
                                            color: Colors.red,
                                          ),
                                    title: Text(value.category.name),
                                    subtitle: Text('Rs:${value.amount}'),
                                    trailing: Text(
                                      parseDate(value.date),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (ctx, index) {
                            return SizedBox(
                              height: 10.h,
                            );
                          },
                          // ignore: prefer_is_empty
                          itemCount:
                              transactionProviderClass.transactionList.length)
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 49),
                            child: Column(
                              children: [
                                const SizedBox(height: 4),
                                Lottie.asset(
                                    'enimations/animation_lkknttjy.json',
                                    width: 195.w,
                                    height: 195.h),
                                kHeight(5.h),
                                const Text(
                                  "  No transactions yet !",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))
            ],
          ),
        );
      },
    );
  }

  

  void showPopupMenu() async {
    await showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 80, 10, 10),
      items: [
        PopupMenuItem(
            onTap: () {
              // TransactionDb.instance.filterDataByDate('all');
              Provider.of<TransactionProvider>(context, listen: false)
                  .filterDataByDate('all');
            },
            child: const Text(
              'All',
              style: TextStyle(fontWeight: FontWeight.bold, color: mainColor),
            )),
        PopupMenuItem(
            onTap: () {
              // TransactionDb.instance.filterDataByDate('today');
              Provider.of<TransactionProvider>(context, listen: false)
                  .filterDataByDate('today');
            },
            child: const Text(
              'Today',
              style: TextStyle(fontWeight: FontWeight.bold, color: mainColor),
            )),
        PopupMenuItem(
            onTap: () {
              //TransactionDb.instance.filterDataByDate('yesterday');
              Provider.of<TransactionProvider>(context, listen: false)
                  .filterDataByDate('yesterday');
            },
            child: const Text(
              'Yesterday',
              style: TextStyle(fontWeight: FontWeight.bold, color: mainColor),
            )),
        PopupMenuItem(
            onTap: () {
              // TransactionDb.instance.filterDataByDate('last week');
              Provider.of<TransactionProvider>(context, listen: false)
                  .filterDataByDate('last week');
            },
            child: const Text(
              'Last Week',
              style: TextStyle(fontWeight: FontWeight.bold, color: mainColor),
            )),
      ],
      elevation: 8.0,
    );
  }

  void showPopupMenu1() async {
    await showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 80, 10, 10),
      items: [
        PopupMenuItem(
            onTap: () {
              Provider.of<TransactionProvider>(context, listen: false)
                  .filter('All');
              // TransactionDb.instance.filter('All');
              // TransactionDb.instance.refresh();
              Provider.of<TransactionProvider>(context, listen: false)
                  .refresh();
            },
            child: const Text(
              'All',
              style: TextStyle(fontWeight: FontWeight.bold, color: mainColor),
            )),
        PopupMenuItem(
            onTap: () {
              // TransactionDb.instance.filter('Income');
              Provider.of<TransactionProvider>(context, listen: false)
                  .filter("Income");
            },
            child: const Text(
              'Income',
              style: TextStyle(fontWeight: FontWeight.bold, color: mainColor),
            )),
        PopupMenuItem(
            onTap: () {
              // TransactionDb.instance.filter('Expense');
              Provider.of<TransactionProvider>(context, listen: false)
                  .filter("Expense");
            },
            child: const Text(
              'Expense',
              style: TextStyle(fontWeight: FontWeight.bold, color: mainColor),
            )),
      ],
      elevation: 8.0,
    );
  }

  String parseDate(DateTime date) {
    final ddate = DateFormat.MMMd().format(date);
    final splitedDate = ddate.split(' ');
    return '${splitedDate.last}\n${splitedDate.first}';
  }
}

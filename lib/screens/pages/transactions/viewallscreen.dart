import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:stash_project/db/transaction/transaction_db.dart';
import 'package:stash_project/models/category/category_model.dart';
import 'package:stash_project/models/transaction/transaction_model.dart';
import 'package:stash_project/screens/pages/transactions/edit_transaction.dart';
import '../../../balance/balance.dart';
import '../../../core/constants.dart';
import '../../../db/category/category_db.dart';
import '../../../db/chart/chart_db.dart';

class VeiwAllScreen extends StatefulWidget {
  const VeiwAllScreen({super.key, required this.transactions});
  final List<TranscationModel> transactions;
  @override
  State<VeiwAllScreen> createState() => _VeiwAllScreenState();
}

class _VeiwAllScreenState extends State<VeiwAllScreen> {
  TextEditingController searchController = TextEditingController();
  var clearcntrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TransactionDb.instance.refresh();
    CategoryDB.instance.refreshUI();
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
                child: Card(
                  elevation: 9,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: TextField(
                      controller: clearcntrl,
                      onChanged: (value) {
                        TransactionDb.instance.search(
                          value,
                        );
                      },
                      decoration: InputDecoration(
                          hintText: 'Search..',
                          border: InputBorder.none,
                          icon: const Icon(
                            Icons.search,
                            // color: textClr,
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {
                                clearcntrl.clear();
                                TransactionDb.instance.refresh();
                                CategoryDB.instance.refreshUI();
                              },
                              icon: const Icon(
                                Icons.close,
                                // color: Colors.black,
                              ))),
                    ),
                  ),
                ),
              ),
            ],
          ),
          ValueListenableBuilder(
            valueListenable: TransactionDb.instance.transactionListNotifier,
            builder:
                (BuildContext ctx, List<TranscationModel> newList, Widget? _) {
              return Expanded(
                  child: newList.isNotEmpty
                      ? ListView.separated(
                          itemBuilder: (ctx, index) {
                            final value = newList[index];
                            return Slidable(
                              key: Key(value.id!),
                              endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (ctx) {
                                        showAlert(context, index);
                                      },
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                    SlidableAction(
                                      onPressed: (ctx) {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditTransaction(
                                                      data: value,
                                                      index: index,
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
                        ));
            },
          )
        ],
      ),
    );
  }

  void showAlert(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text(
              'Do you want to delete',
              style: TextStyle(color: Color.fromARGB(255, 228, 15, 15)),
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
                    TransactionDb.instance.deletTransaction(index);
                    Navigator.of(ctx).pop();

                    balanceAmount();
                    TransactionDb.instance.refresh();
                    filterFunction();
                  },
                  child: const Text("Yes"))
            ],
          );
        });
  }

  void showPopupMenu() async {
    await showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 80, 10, 10),
      items: [
        PopupMenuItem(
            onTap: () {
              TransactionDb.instance.filterDataByDate('all');
            },
            child: const Text(
              'All',
              style: TextStyle(fontWeight: FontWeight.bold, color: mainColor),
            )),
        PopupMenuItem(
            onTap: () {
              TransactionDb.instance.filterDataByDate('today');
            },
            child: const Text(
              'Today',
              style: TextStyle(fontWeight: FontWeight.bold, color: mainColor),
            )),
        PopupMenuItem(
            onTap: () {
              TransactionDb.instance.filterDataByDate('yesterday');
            },
            child: const Text(
              'Yesterday',
              style: TextStyle(fontWeight: FontWeight.bold, color: mainColor),
            )),
        PopupMenuItem(
            onTap: () {
              TransactionDb.instance.filterDataByDate('last week');
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
              TransactionDb.instance.filter('All');
              TransactionDb.instance.refresh();
            },
            child: const Text(
              'All',
              style: TextStyle(fontWeight: FontWeight.bold, color: mainColor),
            )),
        PopupMenuItem(
            onTap: () {
              TransactionDb.instance.filter('Income');
            },
            child: const Text(
              'Income',
              style: TextStyle(fontWeight: FontWeight.bold, color: mainColor),
            )),
        PopupMenuItem(
            onTap: () {
              TransactionDb.instance.filter('Expense');
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

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stash_project/provider.dart/category_provider.dart';
import 'package:stash_project/provider.dart/chart_provider.dart';
import 'package:stash_project/screens/pages/transactions/edit_transaction.dart';
import 'package:stash_project/screens/pages/transactions/viewallscreen.dart';
import '../../../core/constants.dart';
import '../../../models/category/category_model.dart';
import '../../../models/transaction/transaction_model.dart';
import '../../../provider.dart/transaction_provider.dart';
import '../menubar/menu.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<TransactionProvider>(context, listen: false).refresh();
    Provider.of<CategoryProvider>(context, listen: false).refreshUI();
    Provider.of<TransactionProvider>(context, listen: false).balanceAmount();
    Provider.of<ChartProvider>(context, listen: false).filterFunction(context);

    List<TranscationModel> transactions = [];
    return Scaffold(
        drawer: const MenuScreen(),
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'STASH',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: mainColor,
          actions: <Widget>[
            IconButton(onPressed: () {
              Provider.of<TransactionProvider>(context, listen: false).refresh();
              Provider.of<CategoryProvider>(context, listen: false).refreshUI();
              Provider.of<TransactionProvider>(context, listen: false).balanceAmount();
              Provider.of<ChartProvider>(context, listen: false).filterFunction(context);
            },
             icon:const Icon(Icons.refresh_outlined))
          ],
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 220.h,
            child: Stack(
              children: [
                Container(
                  height: 180.h,
                  decoration: const BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50))),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 300.w,
                    height: 180.h,
                    child: FlipCard(
                      fill: Fill.fillFront,
                      back: const Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Text(
                          'Manage Your Money',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      front: Card(
                        color: const Color.fromARGB(255, 166, 165, 240),
                        elevation: 60,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Column(children: [
                          kHeight(10.h),
                          Column(
                            children: [
                              Consumer<TransactionProvider>(
                                  builder: (context, transactionProvider, _) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          transactionProvider
                                                      .totalnotifier.value <
                                                  0
                                              ? 'Loss'
                                              : 'Balance',
                                          style: const TextStyle(
                                            fontSize: 28,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.currency_rupee,
                                          size: 20,
                                        ),
                                        Text(
                                          ' ${transactionProvider.totalnotifier.value.toString()}',
                                          style: const TextStyle(
                                            fontSize: 35,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(Icons.arrow_upward),
                                        Text('Income'),
                                      ],
                                    ),
                                    Row(
                                      children: const [
                                        Icon(Icons.arrow_downward),
                                        Text('Expense')
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Consumer<TransactionProvider>(builder:
                                          (context, transactionProvider, _) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: mainColor),
                                          height: 40,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(Icons.currency_rupee,
                                                    size: 15,
                                                    color: Colors.white),
                                                Text(
                                                  transactionProvider
                                                      .incomenotifier.value
                                                      .toString(),
                                                  style: const TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                      Consumer<TransactionProvider>(builder:
                                          (context, transactionProvider, _) {
                                        return Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: mainColor),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(Icons.currency_rupee,
                                                    size: 15,
                                                    color: Colors.white),
                                                Text(
                                                  transactionProvider
                                                      .expensenotifier.value
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )
                        ]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          kHeight(25.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Recent Transactions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: mainColor),
                      onPressed: () {
                        Provider.of<TransactionProvider>(context, listen: false)
                            .refresh();
                        // CategoryDB.instance.refreshUI();
                        Provider.of<CategoryProvider>(context, listen: false)
                            .refreshUI();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VeiwAllScreen(
                                      transactions: transactions,
                                    )));
                      },
                      child: const Text('Veiw All'))
                ],
              )
            ],
          ),
          kHeight(10.h),
          Consumer<TransactionProvider>(
            builder: (context, transactionProviderClass, child) {
              return Expanded(
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
                                        //showAlert(context, id);
                                        value;
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Delete'),
                                                content: const Text(
                                                    'Are you sure?Do you want to delete this transaction?'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
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
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text('Ok'))
                                                ],
                                              );
                                            });
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
                                                      id: id,
                                                      model: value,
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
                                  shadowColor: mainColor,
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
                            return kHeight(10.h);
                          },
                          // ignore: prefer_is_empty
                          itemCount: transactionProviderClass
                                      .transactionList.length >
                                  3
                              ? 3
                              : transactionProviderClass.transactionList.length)
                      : Center(
                          child: Column(
                            children: [
                              const SizedBox(height: 4),
                              Lottie.asset('enimations/animation_lkknttjy.json',
                                  width: 195.w, height: 195.h),
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
                        ));
            },
          )
        ]));
  }

  String parseDate(DateTime date) {
    final ddate = DateFormat.MMMd().format(date);
    final splitedDate = ddate.split(' ');
    return '${splitedDate.last}\n${splitedDate.first}';
  }

  
}

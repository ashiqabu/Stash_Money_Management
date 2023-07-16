import 'package:flutter/material.dart';
import 'package:stash_project/db/chart/chart_db.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../db/category/category_db.dart';
import '../../../db/transaction/transaction_db.dart';
import '../menubar/menu.dart';
import 'insights_model.dart';

class FinancialReport extends StatefulWidget {
  const FinancialReport({Key? key}) : super(key: key);

  @override
  State<FinancialReport> createState() => _FinancialReportState();
}

class _FinancialReportState extends State<FinancialReport>
    with TickerProviderStateMixin {
  List<ChartDatas> dataExpense = chartLogic(expenseNotifier1.value);
  List<ChartDatas> dataIncome = chartLogic(incomeNotifier1.value);
  List<ChartDatas> overview = chartLogic(overviewNotifier.value);
  List<ChartDatas> yesterday = chartLogic(yesterdayNotifier.value);
  List<ChartDatas> today = chartLogic(todayNotifier.value);
  List<ChartDatas> month = chartLogic(lastMonthNotifier.value);
  List<ChartDatas> week = chartLogic(lastWeekNotifier.value);
  List<ChartDatas> todayIncome = chartLogic(incomeTodayNotifier.value);
  List<ChartDatas> incomeYesterday = chartLogic(incomeYesterdayNotifier.value);
  List<ChartDatas> incomeweek = chartLogic(incomeLastWeekNotifier.value);
  List<ChartDatas> incomemonth = chartLogic(incomeLastMonthNotifier.value);
  List<ChartDatas> todayExpense = chartLogic(expenseTodayNotifier.value);
  List<ChartDatas> expenseYesterday =
      chartLogic(expenseYesterdayNotifier.value);
  List<ChartDatas> expenseweek = chartLogic(expenseLastWeekNotifier.value);
  List<ChartDatas> expensemonth = chartLogic(expenseLastMonthNotifier.value);
  late TabController tabController;
  late TooltipBehavior tooltipBehavior;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    tooltipBehavior = TooltipBehavior(enable: true);
    filterFunction();
    CategoryDB().refreshUI();
    TransactionDb().refresh();

    super.initState();
  }

  String categoryId2 = 'All';
  int touchIndex = 1;

  @override
  Widget build(BuildContext context) {
    CategoryDB.instance.refreshUI();
    TransactionDb.instance.refresh();
    filterFunction();
    chartdivertFunctionOverview();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: const MenuScreen(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Insights',
        ),
        backgroundColor: const Color.fromARGB(225, 53, 9, 85),
      ),
      body: SingleChildScrollView(
        child: ValueListenableBuilder(
          valueListenable: expenseNotifier1,
          builder: (context, value, Widget? _) => Column(
            children: [
              SizedBox(
                height: height * 0.039,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 24,
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(18),
                  elevation: 15,
                  child: Container(
                    height: height * 0.057,
                    width: width * 0.85,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 234, 229, 229),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const []),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 10,
                        left: 22,
                      ),
                      child: DropdownButton<String>(
                        style: TextStyle(
                            fontSize: width * 0.042,
                            color: Colors.black,
                            fontWeight: FontWeight.w100),
                        isExpanded: true,
                        underline: Container(),
                        value: categoryId2,
                        items: <String>[
                          'All',
                          'Today',
                          'Yesterday',
                          'This week',
                          'month',
                        ]
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            categoryId2 = value.toString();
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.9,
                child: TabBar(
                  unselectedLabelStyle: const TextStyle(color: Colors.grey),
                  labelStyle: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color.fromARGB(225, 53, 9, 85),
                  ),
                  controller: tabController,
                  labelColor: const Color.fromARGB(255, 255, 255, 255),
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(
                      text: 'All',
                    ),
                    Tab(
                      text: 'Income',
                    ),
                    Tab(
                      text: 'Expense',
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.0263,
              ),
              SizedBox(
                width: double.maxFinite,
                height: height * 0.526,
                child: TabBarView(
                  controller: tabController,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(
                        16,
                      ),
                      child: chartdivertFunctionOverview().isEmpty
                          ? Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                  ),
                                  Text(
                                    "   No transactions yet !",
                                    style: TextStyle(
                                      fontSize: width * 0.055,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SfCircularChart(
                              legend: Legend(
                                isVisible: true,
                                overflowMode: LegendItemOverflowMode.wrap,
                                position: LegendPosition.bottom,
                              ),
                              tooltipBehavior: tooltipBehavior,
                              series: <CircularSeries>[
                                DoughnutSeries<ChartDatas, String>(
                                  enableTooltip: true,
                                  dataSource: chartdivertFunctionOverview(),
                                  xValueMapper: (ChartDatas data, _) =>
                                      data.category,
                                  yValueMapper: (ChartDatas data, _) =>
                                      data.amount,
                                  explode: true,
                                )
                              ],
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(
                        16,
                      ),
                      child: chartdivertFunctionIncome().isEmpty
                          ? Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                  ),
                                  Text(
                                    "   No transactions yet !",
                                    style: TextStyle(
                                      fontSize: width * 0.055,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SfCircularChart(
                              tooltipBehavior: tooltipBehavior,
                              legend: Legend(
                                isVisible: true,
                                overflowMode: LegendItemOverflowMode.wrap,
                                position: LegendPosition.bottom,
                              ),
                              series: <CircularSeries>[
                                DoughnutSeries<ChartDatas, String>(
                                  enableTooltip: true,
                                  dataSource: chartdivertFunctionIncome(),
                                  xValueMapper: (ChartDatas data, _) =>
                                      data.category,
                                  yValueMapper: (ChartDatas data, _) =>
                                      data.amount,
                                  explode: true,
                                )
                              ],
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(
                        16,
                      ),
                      child: chartdivertFunctionExpense().isEmpty
                          ? Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                  ),
                                  Text(
                                    "   No transactions yet !",
                                    style: TextStyle(
                                      fontSize: width * 0.055,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SfCircularChart(
                              tooltipBehavior: tooltipBehavior,
                              legend: Legend(
                                isVisible: true,
                                overflowMode: LegendItemOverflowMode.wrap,
                                position: LegendPosition.bottom,
                              ),
                              series: <CircularSeries>[
                                DoughnutSeries<ChartDatas, String>(
                                  enableTooltip: true,
                                  dataSource: chartdivertFunctionExpense(),
                                  xValueMapper: (ChartDatas data, _) =>
                                      data.category,
                                  yValueMapper: (ChartDatas data, _) =>
                                      data.amount,
                                  explode: true,
                                )
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  chartdivertFunctionOverview() {
    if (categoryId2 == 'All') {
      return overview;
    }
    if (categoryId2 == 'Today') {
      return today;
    }
    if (categoryId2 == 'Yesterday') {
      return yesterday;
    }
    if (categoryId2 == 'This week') {
      return week;
    }
    if (categoryId2 == 'month') {
      return month;
    }
  }

  chartdivertFunctionIncome() {
    if (categoryId2 == 'All') {
      return dataIncome;
    }
    if (categoryId2 == 'Today') {
      return todayIncome;
    }
    if (categoryId2 == 'Yesterday') {
      return incomeYesterday;
    }
    if (categoryId2 == 'This week') {
      return incomeweek;
    }
    if (categoryId2 == 'month') {
      return incomemonth;
    }
  }

  chartdivertFunctionExpense() {
    if (categoryId2 == 'All') {
      return dataExpense;
    }
    if (categoryId2 == 'Today') {
      return todayExpense;
    }
    if (categoryId2 == 'Yesterday') {
      return expenseYesterday;
    }
    if (categoryId2 == 'This week') {
      return expenseweek;
    }
    if (categoryId2 == 'month') {
      return expensemonth;
    }
  }
}

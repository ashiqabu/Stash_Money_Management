import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stash_project/models/category/category_model.dart';
import 'package:stash_project/provider.dart/addtransaction_provider.dart';
import 'package:stash_project/provider.dart/category_provider.dart';
import 'package:stash_project/provider.dart/chart_provider.dart';
import 'package:stash_project/provider.dart/edit_transaction_provider.dart';
import 'package:stash_project/provider.dart/transaction_provider.dart';
import 'package:stash_project/screens/pages/splashscreen/splashscreen.dart';
import 'package:stash_project/screens/pages/welcome-screens/welcomescreen1.dart';
import 'models/profile/profile_model.dart';
import 'models/transaction/transaction_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }

  if (!Hive.isAdapterRegistered(TranscationModelAdapter().typeId)) {
    Hive.registerAdapter(TranscationModelAdapter());
  }
  if (!Hive.isAdapterRegistered(ProfileModelAdapter().typeId)) {
    Hive.registerAdapter(ProfileModelAdapter());
  }

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    bool hasSeenwelcomescreen =
        preference.getBool('hasSeenwelcomescreen') ?? false;

    runApp(MyApp(hasSeenwelcomescreen));
  });
}

class MyApp extends StatelessWidget {
  final bool hasSeenwelcomescreen;
  const MyApp(this.hasSeenwelcomescreen, {super.key});

  @override
  Widget build(BuildContext context) {
    // // CategoryDB.instance.refreshUI();
    // // TransactionDb.instance.refresh();
    // Provider.of<CategoryProvider>(context, listen: false).refreshUI();
    // Provider.of<TransactionProvider>(context, listen: false).refresh();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => TransactionProvider()),
        ChangeNotifierProvider(create: (context) => ChartProvider()),
        ChangeNotifierProvider(create: (context) => AddTransactionsProvider()),
         ChangeNotifierProvider(create: (context) => EditTransactionsProvider())
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
          home: hasSeenwelcomescreen
              ? const SplashScreen()
              : const WelcomeScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}

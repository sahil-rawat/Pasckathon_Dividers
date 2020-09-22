import 'package:flutter/material.dart';
import '../components/fine_collected.dart';
import '../login/log_in.dart';
import '../dashboard/dashboard.dart';
import '../components/scan_results.dart';
import '../components/splashscreen.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: Colors.transparent,
  ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        FinePage.id: (context) => FinePage(),
        MyHomePage.id: (context) => MyHomePage(),
        ScanPage.id: (context) => ScanPage(),
        LogIn.id: (context) => LogIn(),
      },
    );
  }
}

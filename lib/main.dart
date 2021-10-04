import 'package:customapp/pages/dashboard/dashboard_page.dart';
import 'package:customapp/pages/user_dashboard.dart';
import 'package:customapp/pages/login_page.dart';
import 'package:customapp/utils/myRoutes.dart';
import 'package:flutter/material.dart';

main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      initialRoute: MyRoutes.loginRoute,
      routes: {
        "/": (context) => LoginPage(),
        MyRoutes.loginRoute: (context) => LoginPage(),
        MyRoutes.userDashboardRoute: (context) => UserDashboardPage(),
        MyRoutes.mainDashboardRoute: (context) => MainDashboard(),
      },
    );
  }
}

import 'package:flutter/material.dart';

import "./screens/splash.dart";
import "./screens/home.dart";
import "./screens/login.dart";
import "./screens/register.dart";
import "./screens/add_account.dart";
import "./screens/add_transaction.dart";
import "./screens/account_detail.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xff626FB0), accentColor: Color(0xff0626FB0)),
      home: SplashScreen(),
      routes: {
        "/splash": (context) => SplashScreen(),
        "/home": (context) => HomeScreen(),
        "/login": (context) => LoginScreen(),
        "/register": (context) => RegisterScreen(),
        "/addaccount": (context) => AddAccountScreen(),
        "/addtransaction": (context) => AddTransactionScreen(null),
      },
      onGenerateRoute: (settings) {
        var array = settings.name.split("/");
        switch (array[1]) {
          case "addtransaction":
            return MaterialPageRoute(
              builder: (context) => AddTransactionScreen(array[2]),
            );
            break;
          case "account_detail":
            return MaterialPageRoute(
              builder: (context) => AccountDetailScreen(array[2]),
            );
            break;
          default:
        }
      },
    );
  }
}

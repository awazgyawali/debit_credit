import 'dart:async';
import 'package:flutter/material.dart';

import './base_screen.dart';

import '../helper.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    FirebaseHelper().init().then((data) {
      Timer(Duration(seconds: 3), () {
        if (data == null)
          Navigator.pushReplacementNamed(context, "/login");
        else
          Navigator.pushReplacementNamed(context, "/home");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(30),
              alignment: Alignment.center,
              child: Text(
                "DEBIT\nCREDIT",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(height: 40),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}

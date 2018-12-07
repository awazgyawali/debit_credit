import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import './base_screen.dart';

import '../helper.dart';

class LoginScreen extends StatefulWidget {
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var email = "", password = "";
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  emailLogin() {
    if (email.isEmpty || password.isEmpty)
      showSnackbar("Please dont leave any fields empty");
    else
      FirebaseHelper().loginViaEmailPassword(email, password).then((user) {
        Navigator.pushReplacementNamed(context, "/home");
      }).catchError((err) {
        if (err is PlatformException)
          showSnackbar(err.details);
        else
          showSnackbar("Something went wrong, please try again later.");
      });
  }

  showSnackbar(message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Theme.of(context).primaryColor,
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      scaffoldKey: _scaffoldKey,
      child: Container(
        margin: EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            Expanded(child: SizedBox()),
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
            Expanded(child: SizedBox()),
            Container(
              decoration: BoxDecoration(
                color: Color(0xffF2F2F7),
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: Color(0xffD6D6D8), width: 1),
              ),
              margin: EdgeInsets.fromLTRB(00, 10, 0, 10),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            MdiIcons.emailOutline,
                            color: Color(0xff92949F),
                          ),
                          onPressed: () {},
                        ),
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              email = value;
                            },
                            decoration: InputDecoration.collapsed(
                              hintText: "Email",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 0),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            MdiIcons.lock,
                            color: Color(0xff92949F),
                          ),
                          onPressed: () {},
                        ),
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              password = value;
                            },
                            decoration: InputDecoration.collapsed(
                              hintText: "Password",
                            ),
                            obscureText: true,
                          ),
                        ),
                        FlatButton(
                          textColor: Theme.of(context).primaryColor,
                          child: Text("Forgot?"),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                emailLogin();
              },
              child: Container(
                padding: EdgeInsets.all(20),
                width: double.maxFinite,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(3),
                ),
                margin: EdgeInsets.fromLTRB(00, 10, 00, 10),
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Divider(),
                Container(
                  padding: EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xffD6D6D8)),
                  ),
                  child: Text(
                    "or",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff3B5998),
                    ),
                    child: Icon(
                      MdiIcons.facebook,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff4285F4),
                    ),
                    child: Icon(
                      MdiIcons.google,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            Expanded(child: SizedBox()),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Don't have an account? "),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    onTap: () async {
                      var data =
                          await Navigator.pushNamed(context, "/register");
                      if (data) {
                        Navigator.pushReplacementNamed(context, "/home");
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

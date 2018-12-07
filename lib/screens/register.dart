import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:image_picker/image_picker.dart';

import './base_screen.dart';

import '../helper.dart';

class RegisterScreen extends StatefulWidget {
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  var name = "", email = "", mobile = "", password = "", cPassword = "";
  File image;

  registerUser() {
    if (name.isEmpty ||
        email.isEmpty ||
        mobile.isEmpty ||
        password.isEmpty ||
        cPassword.isEmpty)
      showSnackbar("Please dont leave any field empty.");
    else if (image == null)
      showSnackbar("Please choose an image to continue");
    else if (cPassword != password)
      showSnackbar("Confirm password didn't matched.");
    else
      FirebaseHelper().createAccount(name, email, password, image).then((data) {
        Navigator.pop(context, true);
      }).catchError((err) {
        if (err is PlatformException)
          showSnackbar(err.details);
        else
          showSnackbar("Something went wrong, please try again later.");
      });
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      this.image = image;
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
      showBack: true,
      title: "SIGN UP",
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                getImage();
              },
              child: Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff737EB3),
                    image: image != null
                        ? DecorationImage(
                            image: FileImage(image), fit: BoxFit.cover)
                        : null),
                child: Icon(
                  MdiIcons.cameraEnhanceOutline,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Text("PROFILE IMAGE"),
            ),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color(0xffF2F2F7),
                borderRadius: BorderRadius.circular(3),
              ),
              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Icon(
                      MdiIcons.accountOutline,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        name = value;
                      },
                      textCapitalization: TextCapitalization.words,
                      decoration:
                          InputDecoration.collapsed(hintText: "Full Name"),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color(0xffF2F2F7),
                borderRadius: BorderRadius.circular(3),
              ),
              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Icon(
                      MdiIcons.emailOutline,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        email = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration.collapsed(hintText: "Email"),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color(0xffF2F2F7),
                borderRadius: BorderRadius.circular(3),
              ),
              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Icon(
                      MdiIcons.cellphoneAndroid,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        mobile = value;
                      },
                      keyboardType: TextInputType.number,
                      decoration:
                          InputDecoration.collapsed(hintText: "Mobile No"),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color(0xffF2F2F7),
                borderRadius: BorderRadius.circular(3),
              ),
              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Icon(
                      MdiIcons.lock,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        password = value;
                      },
                      obscureText: true,
                      decoration:
                          InputDecoration.collapsed(hintText: "Password"),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color(0xffF2F2F7),
                borderRadius: BorderRadius.circular(3),
              ),
              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Icon(
                      MdiIcons.lock,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        cPassword = value;
                      },
                      obscureText: true,
                      decoration: InputDecoration.collapsed(
                          hintText: "Confirm Password"),
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                registerUser();
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
                  "SIGN UP",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import './base_screen.dart';

import '../helper.dart';

class AddAccountScreen extends StatefulWidget {
  _AddAccountScreenState createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  var name = "", mobile = "";
  var image;

  createAccount() {
    if (name.isEmpty || mobile.isEmpty)
      showSnackbar("Please dont leave any field empty.");
    else if (image == null)
      showSnackbar("Please choose an image to continue");
    else
      FirebaseHelper().addFinanceAccount(name, mobile, image).then((data) {
        Navigator.pop(context);
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
      title: "ADD ACCOUNT",
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
                      : null,
                ),
                child: Icon(
                  MdiIcons.cameraEnhanceOutline,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Text("ACCOUNT IMAGE"),
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
                          InputDecoration.collapsed(hintText: "Account Name"),
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
            GestureDetector(
              onTap: () {
                createAccount();
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
                  "SAVE",
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

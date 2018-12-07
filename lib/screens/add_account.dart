import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import './base_screen.dart';

class AddAccountScreen extends StatefulWidget {
  _AddAccountScreenState createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      showBack: true,
      title: "ADD ACCOUNT",
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          children: <Widget>[
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff737EB3),
              ),
              child: Icon(
                MdiIcons.cameraEnhanceOutline,
                color: Colors.white,
                size: 50,
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Text("ADD PROFILE IMAGE"),
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
                Navigator.pop(context);
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

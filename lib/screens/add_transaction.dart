import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../screens/base_screen.dart';

import '../widgets/income_expense.dart';

class AddTransactionScreen extends StatefulWidget {
  final userId;
  AddTransactionScreen(this.userId);
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  var ie = "income";
  var currentAccount;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "Add Transaction",
      showBack: true,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  IncomeExpense(
                    value: ie,
                    onChanged: (value) {
                      setState(() {
                        ie = value;
                      });
                    },
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Color(0xffF2F2F7),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
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
                            MdiIcons.account,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              iconSize: 0,
                              isDense: true,
                              isExpanded: true,
                              hint: Text("Select Friend"),
                              value: currentAccount,
                              onChanged: (value) {
                                setState(() {
                                  currentAccount = value;
                                });
                              },
                              items: [
                                DropdownMenuItem(
                                  child: Text("Aawaz"),
                                  value: "aawaz",
                                ),
                                DropdownMenuItem(
                                  child: Text("Roshan"),
                                  value: "roshan",
                                ),
                              ],
                            ),
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
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
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
                            MdiIcons.cash,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration.collapsed(
                              hintText: "Enter Amount",
                            ),
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
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
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
                            MdiIcons.pen,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration.collapsed(
                                hintText: "Enter Drescription"),
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
                      padding: EdgeInsets.all(15),
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
          ],
        ),
      ),
    );
  }
}

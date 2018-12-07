import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../screens/base_screen.dart';

import '../widgets/income_expense.dart';

import '../helper.dart';

class AddTransactionScreen extends StatefulWidget {
  final userId;
  AddTransactionScreen(this.userId);
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  var type = "debit", amount = "", description = "";
  var accountKey;
  var accounts = {};

  void initState() {
    super.initState();
    FirebaseHelper().getAccounts().listen((data) {
      setState(() {
        accounts = data.snapshot.value;
      });
    });
  }

  addTransaction() {
    if (amount.isEmpty || description.isEmpty)
      showSnackbar("Please dont leave any field empty.");
    else if (accountKey == null)
      showSnackbar("Please choose an account or create one.");
    else
      FirebaseHelper()
          .addTransaction(
              accountKey, type, accounts[accountKey], amount, description)
          .then((data) {
        Navigator.pop(context);
      }).catchError((err) {
        print(err);
      });
  }

  getItems() {
    List<DropdownMenuItem> items = [];
    items.add(
      DropdownMenuItem(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Add Account",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            Icon(
              MdiIcons.accountPlus,
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
        value: "add",
      ),
    );
    accounts.keys.forEach((key) {
      items.add(
        DropdownMenuItem(
          value: key,
          child: Text(accounts[key]["name"]),
        ),
      );
    });

    DropdownMenuItem(
      child: Text("Aawaz"),
      value: "aawaz",
    );
    DropdownMenuItem(
      child: Text("Roshan"),
      value: "roshan",
    );

    return items;
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
                    value: type,
                    onChanged: (value) {
                      setState(() {
                        type = value;
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
                              hint: Text("Select Account"),
                              value: accountKey,
                              onChanged: (value) {
                                if (value == "add")
                                  Navigator.pushNamed(context, "/addaccount");
                                else
                                  setState(() {
                                    accountKey = value;
                                  });
                              },
                              items: getItems(),
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
                            onChanged: (value) {
                              amount = value;
                            },
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
                            onChanged: (value) {
                              description = value;
                            },
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
                      addTransaction();
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

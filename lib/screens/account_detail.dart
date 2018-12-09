import 'package:flutter/material.dart';

import './base_screen.dart';

import '../helper.dart';

class AccountDetailScreen extends StatefulWidget {
  final accountKey;
  AccountDetailScreen(this.accountKey);
  _AccountDetailScreenState createState() => _AccountDetailScreenState();
}

class _AccountDetailScreenState extends State<AccountDetailScreen> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var account;
  var transactions = {};

  void initState() {
    super.initState();
    updateAccount();
    getAccountDetail();
  }

  updateAccount() async {
    FirebaseHelper().getAccountDetail(widget.accountKey).listen((data) {
      setState(() {
        this.account = data.snapshot.value;
      });
    });
  }

  getAccountDetail() async {
    var transactions =
        await FirebaseHelper().getTransactionsOf(widget.accountKey);
    print(transactions);
    setState(() {
      this.transactions = transactions;
    });
  }

  showSnackbar(message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Theme.of(context).primaryColor,
      content: Text(message),
    ));
  }

  getEmptyTransactionWidget() {
    return Container(
      height: 300,
      child: Center(
        child: Text(
          "No transsactions added,\nadd some to start accounting.",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      scaffoldKey: _scaffoldKey,
      showBack: true,
      title: "",
      child: account == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(account["photo_url"]),
                    ),
                  ),
                  Text(
                    account["name"],
                    style: Theme.of(context).textTheme.title.copyWith(
                        color: Theme.of(context).accentColor, fontSize: 30),
                  ),
                  Text(
                    account["mobile"],
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15, bottom: 30),
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Rs ${account["total"]} /-",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          )
                        ],
                      ),
                    ),
                    height: 100,
                  ),
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: Text(
                      "Transactions",
                      style: Theme.of(context).textTheme.title.copyWith(
                            color: Theme.of(context).accentColor,
                            fontSize: 20,
                          ),
                    ),
                  ),
                  transactions == null
                      ? getEmptyTransactionWidget()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: transactions.keys.map<Widget>((key) {
                            return DetailTransactionItem(transactions[key]);
                          }).toList(),
                        )
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Add Transaction"),
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, "/addtransaction/${widget.accountKey}");
        },
      ),
    );
  }
}

class DetailTransactionItem extends StatelessWidget {
  final transaction;
  DetailTransactionItem(this.transaction);

  getColor() {
    switch (transaction["type"]) {
      case "credit":
        return Colors.red;
        break;
      case "debit":
        return Colors.green;
        break;
      default:
        return Colors.amber;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: double.maxFinite,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "Rs ${transaction["amount"]}",
                  style: TextStyle(
                      color: getColor(),
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ),
              Text(
                "10 days ago",
                style:
                    TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
              ),
            ],
          ),
          Text(
            "${transaction["detail"]}",
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}

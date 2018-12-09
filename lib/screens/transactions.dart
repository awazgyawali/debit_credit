import 'package:flutter/material.dart';

import '../widgets/marquee_text.dart';
import '../helper.dart';

class TransactionsScreen extends StatefulWidget {
  TransactionsScreen({Key key}) : super(key: key);
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshot) {
        if (snapshot.error != null)
          return Center(child: Text("Unable to connect to the server"));
        else if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        else if (snapshot.data.snapshot.value != null) {
          var data = snapshot.data.snapshot.value;
          return ListView.builder(
            itemCount: data.keys.length,
            itemBuilder: (context, index) {
              var transaction = data[data.keys.toList()[index]];
              return Container(
                margin: EdgeInsets.all(10),
                child: TransactionItem(transaction),
              );
            },
          );
        } else
          return Center(child: Text("No transactions made."));
      },
      stream: FirebaseHelper().getTransactions(),
    );
  }
}

class TransactionItem extends StatelessWidget {
  final transaction;
  TransactionItem(this.transaction);

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
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.pushNamed(
            context, "/account_detail/${transaction["account_key"]}");
      },
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(transaction["photo_url"]),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  transaction["account_name"],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Row(
                  children: <Widget>[
                    Text(
                      "Rs ${transaction["amount"]}",
                      style: TextStyle(
                        color: getColor(),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: MarqueeWidget(
                        direction: Axis.horizontal,
                        animationDuration: Duration(seconds: 3),
                        child: Text(
                          "- ${transaction["detail"]}",
                          maxLines: 1,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

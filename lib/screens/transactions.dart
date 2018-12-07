import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../widgets/marquee_text.dart';

class TransactionsScreen extends StatefulWidget {
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TransactionItem(),
            Divider(),
            TransactionItem(),
            Divider(),
            TransactionItem(),
            Divider(),
          ],
        ),
      ),
    );
  }
}

class TransactionItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10),
          child: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
                "https://avatars1.githubusercontent.com/u/10810343?s=460&v=4"),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                "Roshan Gautam",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Row(
                children: <Widget>[
                  Text(
                    "Rs ",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "100",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: MarqueeWidget(
                      direction: Axis.horizontal,
                      animationDuration: Duration(seconds: 3),
                      child: Text(
                        "- This should be a",
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
    );
  }
}

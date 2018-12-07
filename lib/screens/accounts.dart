import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AccountsScreen extends StatefulWidget {
  _AccountsScreenState createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            AccountItem(),
            Divider(),
            AccountItem(),
            Divider(),
            AccountItem(),
            Divider(),
          ],
        ),
      ),
    );
  }
}

class AccountItem extends StatelessWidget {
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
                  Text("has to pay you "),
                  Text(
                    "Rs 2000",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        PopupMenuButton(
          onSelected: (value) {},
          icon: Icon(
            MdiIcons.dotsVertical,
            color: Theme.of(context).primaryColor,
          ),
          itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text(
                    "Edit",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  value: "edit",
                ),
                PopupMenuItem(
                  child: Text(
                    "Delete",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  value: "delete",
                ),
              ],
        )
      ],
    );
  }
}

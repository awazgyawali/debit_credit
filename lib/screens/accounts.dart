import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../helper.dart';

class AccountsScreen extends StatefulWidget {
  AccountsScreen({Key key}) : super(key: key);
  _AccountsScreenState createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshot) {
        if (snapshot.error != null)
          return Center(child: Text("Unable to connect to the server"));
        else if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        else if (snapshot.data != null) {
          var data = snapshot.data.snapshot.value;
          if (data != null)
            return ListView.builder(
              itemCount: data.keys.length,
              itemBuilder: (context, index) {
                var account = data[data.keys.toList()[index]];
                return Container(
                  margin: EdgeInsets.all(10),
                  child: AccountItem(
                    account,
                    onTap: () {
                      Navigator.pushNamed(context,
                          "/account_detail/${data.keys.toList()[index]}");
                    },
                    onDelete: () {
                      FirebaseHelper().deleteAccount(data.keys.toList()[index]);
                    },
                    onEdit: () {},
                  ),
                );
              },
            );
          return Center(child: Text("No Accounts set till now"));
        }
      },
      stream: FirebaseHelper().getAccounts(),
    );
  }
}

class AccountItem extends StatelessWidget {
  final account;
  final onDelete, onEdit, onTap;
  AccountItem(this.account, {this.onDelete, this.onEdit, this.onTap});

  getSummaryText() {
    if (account["total"] == 0)
      return Text("No business to be done.");
    else if (account["total"] > 0)
      return Row(
        children: <Widget>[
          Text("You need to pay "),
          Text(
            "Rs ${account["total"]}",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
    else
      return Row(
        children: <Widget>[
          Text("has to pay you "),
          Text(
            "Rs ${account["total"].abs()}",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(account["photo_url"]),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  account["name"],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                getSummaryText()
              ],
            ),
          ),
          PopupMenuButton(
            onSelected: (value) {
              if (value == "edit")
                onEdit();
              else if (value == "delete") onDelete();
            },
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
      ),
    );
  }
}

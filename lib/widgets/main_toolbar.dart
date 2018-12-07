import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../helper.dart';

class MainToolbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.fromLTRB(10, 25, 10, 25),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Text(
              "Debit Credit",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff92949F),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    MdiIcons.printerSettings,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {},
                ),
                PopupMenuButton(
                  icon: Icon(
                    MdiIcons.dotsVertical,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                  onSelected: (value) {
                    FirebaseHelper().logout().then((data) {
                      Navigator.pushReplacementNamed(context, "/login");
                    });
                  },
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text(
                            "Rate Us",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          value: "rate",
                        ),
                        PopupMenuItem(
                          child: Text(
                            "About Us",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          value: "about",
                        ),
                      ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

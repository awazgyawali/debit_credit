import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BackToolbar extends StatelessWidget {
  final title;
  BackToolbar(this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xff92949F),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
          IconButton(
            icon: Icon(
              MdiIcons.chevronLeft,
              size: 30,
            ),
            onPressed: () {
              print("object");
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

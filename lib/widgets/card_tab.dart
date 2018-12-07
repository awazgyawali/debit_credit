import 'package:flutter/material.dart';

class CardTab extends StatelessWidget {
  final IconData icon;
  final String text;
  final selected;
  final Function onTap;
  CardTab({this.icon, this.text, this.selected, this.onTap});

  getMainColor(context) {
    if (selected) return Colors.white;
    return Theme.of(context).primaryColor;
  }

  getBackgroundColor(context) {
    if (selected) return Theme.of(context).primaryColor;
    return Color(0xffF2F2F7);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: getBackgroundColor(context),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(3),
        child: Column(
          children: <Widget>[
            Icon(
              icon,
              color: getMainColor(context),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: Text(
                text,
                style: TextStyle(color: getMainColor(context)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

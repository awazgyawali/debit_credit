import 'package:flutter/material.dart';

import '../widgets/back_toolbar.dart';

class BaseScreen extends StatefulWidget {
  final Widget child, floatingActionButton;
  final showBack, title;
  final scaffoldKey;
  BaseScreen(
      {this.child,
      this.scaffoldKey,
      this.floatingActionButton,
      this.title,
      this.showBack = false});

  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            widget.showBack ? BackToolbar(widget.title) : SizedBox(),
            Expanded(
              child: widget.child,
            ),
          ],
        ),
      ),
      floatingActionButton: widget.floatingActionButton,
    );
  }
}

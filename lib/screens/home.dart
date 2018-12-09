import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import './base_screen.dart';
import './transactions.dart';
import './accounts.dart';
import './summary.dart';

import '../widgets/card_tab.dart';
import '../widgets/main_toolbar.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var key1 = GlobalKey(), key2 = GlobalKey(), key3 = GlobalKey();
  var selected = 1;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
  }

  animateTo(index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    setState(() {
      selected = index;
    });
  }

  getFAB() {
    if (selected == 0)
      return FloatingActionButton.extended(
        icon: Icon(MdiIcons.plus),
        label: Text("Add Transaction"),
        onPressed: () {
          Navigator.pushNamed(context, "/addtransaction");
        },
      );
    else if (selected == 1)
      return FloatingActionButton.extended(
        icon: Icon(MdiIcons.accountPlus),
        label: Text("Add Account"),
        onPressed: () {
          Navigator.pushNamed(context, "/addaccount");
        },
      );
    else if (selected == 2) return null;
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        children: <Widget>[
          MainToolbar(),
          Row(
            children: <Widget>[
              Expanded(
                child: CardTab(
                  text: "Transaction",
                  icon: MdiIcons.bankTransfer,
                  selected: selected == 0,
                  onTap: () {
                    animateTo(0);
                  },
                ),
              ),
              Expanded(
                child: CardTab(
                  text: "Accounts",
                  icon: MdiIcons.accountMultiple,
                  selected: selected == 1,
                  onTap: () {
                    animateTo(1);
                  },
                ),
              ),
              Expanded(
                child: CardTab(
                  text: "Summary",
                  icon: Icons.monetization_on,
                  selected: selected == 2,
                  onTap: () {
                    animateTo(2);
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              onPageChanged: (index) {
                setState(() {
                  selected = index;
                });
              },
              controller: _pageController,
              children: <Widget>[
                TransactionsScreen(key: key1),
                AccountsScreen(key: key2),
                SummaryScreen(key: key3)
              ],
            ),
          )
        ],
      ),
      floatingActionButton: getFAB(),
    );
  }
}

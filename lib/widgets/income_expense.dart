import 'package:flutter/material.dart';

class IncomeExpense extends StatelessWidget {
  final value;
  final onChanged;

  IncomeExpense({this.value = "income", this.onChanged});
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: Color(0xffF2F2F7),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: RadioListTile(
              isThreeLine: false,
              title: Text("Income"),
              value: "income",
              groupValue: value,
              onChanged: onChanged,
            ),
          ),
          Container(
            height: 25,
            width: 1,
            color: Colors.grey,
          ),
          Expanded(
            child: RadioListTile(
              title: Text("Expense"),
              value: "expense",
              groupValue: value,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

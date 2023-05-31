import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_second_app/widgets/screen.dart';
import '../models/transaction.dart';

class ChartBar extends StatefulWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;
  final List<Transaction> transactions;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal,
      this.transactions);

  @override
  _ChartBarState createState() => _ChartBarState();
}

class _ChartBarState extends State<ChartBar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.label.isNotEmpty &&
            widget.spendingAmount > 0 &&
            widget.spendingPctOfTotal > 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
                // builder: (context) => Screen(
                //   widget.transactions[index].title,
                //   widget.transactions[index].amount,
                //   DateFormat.yMMMd().format(widget.transactions[index].date),
                // ),
                ),
          );
        }
      },
      child: Column(
        children: <Widget>[
          Container(
            height: 20,
            child: FittedBox(
              child: Text('\$ ${widget.spendingAmount.toStringAsFixed(0)}'),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            height: 60,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: widget.spendingPctOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(widget.label),
        ],
      ),
    );
  }
}

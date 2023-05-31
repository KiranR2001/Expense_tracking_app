import 'package:flutter/material.dart';
import 'package:my_second_app/models/transaction.dart';
import 'package:my_second_app/widgets/chart_bar.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import './screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './new_transaction.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  //List<Transaction> _transactions;
  // String savedtitle;
  // String savedamount;
  // String saveddate;

  @override
  void initState() {
    super.initState();
    // _transactions = widget.transactions;
    // print('trnsactions:' + widget.transactions.toString());
    // getSavedData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      child: widget.transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transaction added yet!',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('\$${widget.transactions[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text(
                      widget.transactions[index].title,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd()
                          .format(widget.transactions[index].date),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () =>
                          widget.deleteTx(widget.transactions[index].id),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Screen(
                                  widget.transactions[index].title,
                                  widget.transactions[index].amount,
                                  DateFormat.yMMMd().format(
                                      widget.transactions[index].date))));
                    },
                  ),
                );
              },
              itemCount: widget.transactions.length,
            ),
    );
  }

  // Future<void> saveDataToStorage(tc, ac, dt) async {
  //   // print(tc);

  //   final sharedPrefs = await SharedPreferences.getInstance();
  //   await sharedPrefs.setString('saved_title', tc);
  //   await sharedPrefs.setString('saved_amount', ac);
  //   await sharedPrefs.setString('saved_date', dt);
  // }

  // Future<void> getSavedData() async {
  //   final sharedPrefs = await SharedPreferences.getInstance();
  //   savedtitle = sharedPrefs.getString('saved_title');
  //   savedamount = sharedPrefs.getString('saved_amount');
  //   saveddate = sharedPrefs.getString('saved_date');
  //   setState(
  //     () {},
  //   );

  //   /*if (savedValue != null) {
  //     Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => Screen()));
  //   }*/
  // }
}

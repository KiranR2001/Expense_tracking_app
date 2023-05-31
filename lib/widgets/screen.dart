import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Screen extends StatefulWidget {
  // const Screen({Key key}) : super(key: key);
  String savedtitle;
  double savedamount;
  String saveddate;
  Screen(this.savedtitle, this.savedamount, this.saveddate);

  @override
  State<Screen> createState() =>
      ScreenState(this.savedtitle, this.savedamount, this.saveddate);
}

class ScreenState extends State<Screen> {
  String savedtitle;
  double savedamount;
  String saveddate;
  // String savedTransactions;
  ScreenState(this.savedtitle, this.savedamount, this.saveddate);

  @override
  void initState() {
    super.initState();
    getSavedData();
  }

  // List<Transaction> _printTransaction = [];

  // Future<void> _printList(
  //     String txTitle, double txAmount, DateTime chosenDate) async {
  //   final sharedPrefs = await SharedPreferences.getInstance();
  //   final newTx = Transaction(
  //     title: txTitle,
  //     amount: txAmount,
  //     date: chosenDate,
  //   );
  //   _printTransaction.add(newTx);
  //   String encodedData = Transaction.encode(_printTransaction);
  //   await sharedPrefs.setString('transactions', encodedData);
  //   // String savedlist = sharedPrefs.getString('transactions');
  //   // print(savedlist);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Storage Screen"),
      ),
      body: Center(
        child: Text('$savedtitle $savedamount $saveddate '),
      ),
    );
  }

  Future<void> getSavedData() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    savedtitle = sharedPrefs.getString('saved_title');
    savedamount = sharedPrefs.getDouble('saved_amount');
    saveddate = sharedPrefs.get('saved_date');

    // savedTransactions = sharedPrefs.getString('transactions');
    // print(savedTransactions);
    // _printTransaction = Transaction.decode(savedTransactions);
    setState(() {
      // this.savedtitle = savedtitle;
      // this.savedamount = savedamount;
      // this.saveddate = saveddate;
    });

    /*if (savedValue != null) {
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => Screen()));
    }*/
  }
}

/*"void initState() {
    super.initState();
    getSavedData();
  }". Here getSavedData() is a method where it saves the data through shared preference.My  requirement is that if there is a data in my shared preference , the main screen of my app should indicate the presence of the data through a listviewbuilder that lists the data present. The listviewbuilder is already there in my another file named "transaction_list.dart".So could you help to bring changes in my code inorder to obtain the desired output?

*/

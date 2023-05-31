import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleSmall: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              // button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    getSavedData();
  }

  // String savedtitle = '12';
  // String savedamount = '';
  // String saveddate = '';
  //String titleInput;
  List<Transaction> _userTransactions = [
    // Transaction(
    // id: 't1',
    //title: 'new_shoes',
    //amount: 69.99,
    //date: DateTime.now(),
    //),
    // Transaction(
    //  id: 't2',
    //  title: 'weekly_groceries',
    // amount: 16.65,
    // date: DateTime.now(),
    //),
  ];

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  Future<void> _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );
    _userTransactions.add(newTx);
    String encodedData = Transaction.encode(_userTransactions);
    await sharedPrefs.setString('transactions', encodedData);
    // String savedlist = sharedPrefs.getString('transactions');
    //print(savedlist);
    setState(() {});
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    _userTransactions.removeWhere((tx) => tx.id == id);
    String encodedData = Transaction.encode(_userTransactions);
    await sharedPrefs.setString('transactions', encodedData);
    // String savedlist = sharedPrefs.getString('transactions');
    setState(
      () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personal Expenses',
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //Text(savedtitle),
            Chart(_recentTransaction),
            TransactionList(_userTransactions, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> getSavedData() async {
    // SharedPreferences
    final sharedPrefs = await SharedPreferences.getInstance();
    // savedtitle = sharedPrefs.getString('saved_title');
    // savedamount = sharedPrefs.getString('saved_amount');
    // saveddate = sharedPrefs.getString('saved_date');
    String savedTransactions = sharedPrefs.getString('transactions');
    _userTransactions = Transaction.decode(savedTransactions);
    // List<Transaction> transactions = [
    //   Transaction(id: '2', title: 'shoes', amount: 21, date: DateTime.now()),
    //   Transaction(id: '3', title: 'shoes', amount: 21, date: DateTime.now())
    // ];

    setState(
      () {
        // this.savedtitle = savedtitle;
        // this.savedamount = savedamount;
        // this.saveddate = saveddate;
        // if (savedtitle != null && savedamount != null && saveddate != null) {
        //   // _transactions.add(Transaction(
        //   //     title: savedtitle,
        //   //     amount: double.parse(savedamount),
        //   //     date: DateTime.parse(saveddate),
        //   //     id: DateTime.now().toString()));
        //   // widget.addT(savedtitle, savedamount, saveddate);
        // }
      },
    );

    /*if (savedValue != null) {
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => Screen()));
    }*/
  }
}

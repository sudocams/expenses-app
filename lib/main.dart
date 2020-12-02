import 'package:expences/widgets/chart.dart';


import './widgets/transaction_list.dart';

import './widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch:Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(
          title:TextStyle(
            fontFamily:'QuickSand',
            fontWeight:FontWeight.bold,
            fontSize:18
        ),
        button: TextStyle(color: Colors.white),
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily:'QuickSand',
              fontSize:20,
            )
          ),
          ) 
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String titleAmount;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   final List<Transaction> _userTransaction =[
    Transaction(id: 't1', title: 'new shoes', amount:167.90, date: DateTime.now(),),
    Transaction(id: 't2', title: 'new vest', amount:102.90, date: DateTime.now(),),
    Transaction(id: 't3', title: 'new phone', amount:500.90, date: DateTime.now(),),
    Transaction(id: 't4', title: 'new laptop', amount:765.90, date: DateTime.now(),),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((element){
      return element.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
        );
    }).toList();
  }
  void _addNewTransaction(String txttitle, double txtamount, DateTime choosenDate) {
    final newTr = Transaction(
      title: txttitle,
      amount: txtamount,
      date: choosenDate,
      id: DateTime.now().toString(),
       );

      setState(() {
        _userTransaction.add(newTr);
      });
  }
  void _startNewTransaction(BuildContext ctx){
    showModalBottomSheet(
      context: ctx, 
      builder: (bctx) {
        return GestureDetector(
          onTap: (){},
          child:NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses',),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: ()=> _startNewTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_userTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat ,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=>_startNewTransaction(context),
      )
    );
  }
}

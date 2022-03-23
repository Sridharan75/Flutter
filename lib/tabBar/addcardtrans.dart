import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import '../bottomNavigationBarItems/AddCardPage.dart';
import '../bottomNavigationBarItems/AddTransactionPage.dart';
import '../bottomNavigationBarItems/SummaryPage.dart';

void addcardtrans() => runApp(const Addcardtrans());

class Addcardtrans extends StatelessWidget {
  const Addcardtrans({Key? key}) : super(key: key);

  static const String _title = 'Credit Card Manager';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  final List<Widget> _children = [
    AddCardPage(),
    AddTransactionPage(),
    SummaryPage(),
  ];
  // static const TextStyle optionStyle =
  // TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // static const List<Widget> _widgetOptions = <Widget>[
  //   Text(
  //     'Index 0: Add a card',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Index 1: Add a Transaction',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Index 2: Summary',
  //     style: optionStyle,
  //   ),
  // ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'Add a card',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on_outlined),
            label: 'Add a Transaction',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Summary',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueGrey,
        onTap: _onItemTapped,
      ),
    );
  }
}

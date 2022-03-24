import 'package:flutter/material.dart';
import '../bottomNavigationBarItems/AddCardPage.dart';
import '../bottomNavigationBarItems/AddTransactionPage.dart';
import '../bottomNavigationBarItems/SummaryPage.dart';

class Addcardtrans extends StatelessWidget {
  const Addcardtrans({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyStatefulWidget();
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

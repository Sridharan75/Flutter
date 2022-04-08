import 'package:flutter/material.dart';
import '../sql_helper.dart';

class transaction extends StatefulWidget {
  const transaction({Key? key}) : super(key: key);

  @override
  State<transaction> createState() => _transactionState();
}

class _transactionState extends State<transaction> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
            child: Text(
            "Transaction Page",
            textScaleFactor: 2,
            style: TextStyle(color: Colors.blue),
              ),
      ),
    );
  }
}

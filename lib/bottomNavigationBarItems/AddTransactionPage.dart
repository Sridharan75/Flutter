import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTransactionPage extends StatelessWidget {
  const AddTransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text(
        "Add Transaction Page",
        textScaleFactor: 2,
        style: TextStyle(color: Colors.blue),
      ),
    );
  }
}

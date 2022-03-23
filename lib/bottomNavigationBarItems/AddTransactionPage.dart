import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTransactionPage extends StatelessWidget {
  const AddTransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 150.0,
          width: 190.0,
          padding: EdgeInsets.only(top: 40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
          ),
          child: const Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(hintText: 'Transaction Title'),
            ),
          ),
        ),
        Container(
          height: 150.0,
          width: 190.0,
          // padding: EdgeInsets.only(top: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
          ),
          child: const Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(hintText: 'Transaction Amount'),
            ),
          ),
        ),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            primary: const Color(0xff607d8b),
          ),
          child: Container(
            margin: const EdgeInsets.all(12),
            child: const Text(
              'Add Transaction',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text(
        "Summary Page",
        textScaleFactor: 2,
        style: TextStyle(color: Colors.blue),
      ),
    );
  }
}

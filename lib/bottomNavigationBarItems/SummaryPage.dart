import 'package:flutter/material.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({Key? key}) : super(key: key);

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
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


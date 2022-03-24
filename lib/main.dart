import 'package:flutter/material.dart';
import 'dashboard.dart';

Future<void> main() async {
  await initialization(null);
  runApp(const MyApp());
}

 Future initialization(BuildContext? context) async {
  //load resources
  await Future.delayed(Duration(microseconds:600));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Credit Card Manager',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const Dashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}
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

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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

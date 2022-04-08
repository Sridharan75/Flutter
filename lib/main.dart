import 'package:flutter/material.dart';
import 'dashboard.dart';

Future<void> main() async {
  await initialization(null);

  runApp(const MyApp());
}

class Styles {
  static const Color primary_color = Color(0xFF73BDC5);
  static const Color primary_black = Color(0xFF464E57);
  static const Color custom_savings_blue = Color(0xFF9BC6E9);
  static const Color custom_income_green = Color(0xFFC8DD8E);
  static const Color custom_expense_red = Color(0xFFF57C61);
  static const Color custom_lend_yellow = Color(0xFFF7D644);
  
  static const Color custom_borrow_pink = Color(0xFFDD99C3);
  static const paragraphStructStyle=StrutStyle(
    
    height: 1.2,
    leading: 1.2,
  );
  static const BodyStylePara= TextStyle(
      fontSize: 15,
      color: Colors.grey,
      wordSpacing: 2);
  static const dropHeadStyle=TextStyle(
    color: Colors.grey,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static const LoginHeader = TextStyle(
    fontSize: 24.0,
    color: Colors.white,
    fontFamily: 'nunito',
    fontWeight: FontWeight.w500,
  );

  static const bold25 = TextStyle(
    fontSize: 25.0,
    color: Styles.primary_black,
    fontFamily: 'nunito',
    fontWeight: FontWeight.bold,
  );
  static const boldwhite = TextStyle(
    fontSize: 17.0,
    color: Colors.white,
    fontFamily: 'nunito',
  );
  static const normal17red = TextStyle(
    fontSize: 17.0,
    color: Colors.redAccent,
    fontFamily: 'nunito',
  );
  static const TextStyle normal17 = TextStyle(
    fontSize: 17.0,
    color: Styles.primary_black,
    fontFamily: 'nunito',
    
  );
  static const normal20 = TextStyle(
    fontSize: 20.0,
    color: Styles.primary_black,
    fontFamily: 'nunito',
  );
}

Future initialization(BuildContext? context) async {
  
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

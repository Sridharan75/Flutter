import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:credit_card_manage_2/tabBar/creditcards.dart';
import 'package:credit_card_manage_2/tabBar/transaction.dart';
import 'package:credit_card_manage_2/tabBar/addcardtrans.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Credit Card Manager',
              style: TextStyle(color: Colors.white)),
          centerTitle: true,
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.notifications),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.credit_card)),
              Tab(icon: Icon(Icons.monetization_on_outlined)),
              Tab(icon: Icon(Icons.add)),
            ],
          ),
        ),
        drawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                image: DecorationImage(
                  image: AssetImage('assets/card-logo.png'),
                  scale: 5,
                ),
              ),
              child: Text('Menu'),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const ExpansionTile(
              leading: Icon(Icons.monetization_on_outlined),
              title: Text('Transactions'),
              children: <Widget>[
                ListTile(title: Text('Installments')),
                ListTile(title: Text('ATM withdraws')),
              ],
            ),
            ExpansionTile(
              leading: const Icon(Icons.credit_card),
              title: const Text('Cards'),
              children: <Widget>[
                ListTile(
                    title: const Text('Master Card'),
                    leading: Image.asset(
                      'assets/master-card.png',
                      scale: 1.0,
                      height: 30.0,
                      width: 30.0,
                    )),
                ListTile(
                    title: const Text('Visa Card'),
                    leading: Image.asset(
                      'assets/visa-card.png',
                      scale: 1.0,
                      height: 20.0,
                      width: 20.0,
                    )),
                ListTile(
                    title: const Text('American Express Card'),
                    leading: Image.asset(
                      'assets/american-express-card.png',
                      scale: 1.0,
                      height: 20.0,
                      width: 20.0,
                    )),
              ],
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        )),
        body: TabBarView(children: [
          Creditcards(),
          const Transaction(),
          const Addcardtrans()
        ]),
      ),
    );
  }
}

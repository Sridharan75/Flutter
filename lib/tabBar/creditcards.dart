import 'package:flutter/material.dart';
import '../screens/homeScreen.dart';
import '../sql_helper.dart';

void creditcards() => runApp(Creditcards());

class Creditcards extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreditcardsState();
  }
}

class CreditcardsState extends State<Creditcards> {
  // All journals
  List<Map<String, dynamic>> _journals = [];

  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals(); // Loading the diary when the app starts
  }

  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _cardTypeController = TextEditingController();
  final TextEditingController _creditLimitController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void _showForm(int? id) async {
    if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingJournal =
      _journals.firstWhere((element) => element['id'] == id);
      _bankNameController.text = existingJournal['bankName'];
      _cardTypeController.text = existingJournal['cardType'];
      _creditLimitController.text = existingJournal['creditLimit'];
      _cardNumberController.text = existingJournal['cardNumber'];
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
          padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            // this will prevent the soft keyboard from covering the text fields
            bottom: MediaQuery.of(context).viewInsets.bottom + 120,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _bankNameController,
                decoration: const InputDecoration(hintText: 'Bank Name'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _cardTypeController,
                decoration: const InputDecoration(hintText: 'Card Type(VISA/MASTER/AMERICAN EXPRESS)'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _creditLimitController,
                decoration: const InputDecoration(hintText: 'Credit Limit'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _cardNumberController,
                decoration: const InputDecoration(hintText: 'Card Number (Last 4 digit)'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  // Save new journal
                  if (id == null) {
                    await _addItem();
                  }

                  if (id != null) {
                    await _updateItem(id);
                  }

                  // Clear the text fields
                  _bankNameController.text = '';
                  _cardTypeController.text = '';
                  _creditLimitController.text = '';
                  _cardNumberController.text='';

                  // Close the bottom sheet
                  Navigator.of(context).pop();
                },
                child: Text(id == null ? 'Create New' : 'Update'),
              )
            ],
          ),
        ));
  }

// Insert a new journal to the database
  Future<void> _addItem() async {
    await SQLHelper.createItem(
        _bankNameController.text, _cardTypeController.text, _creditLimitController.text, _cardNumberController.text);
    _refreshJournals();
  }

  // Update an existing journal
  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
        id, _bankNameController.text, _cardTypeController.text,_creditLimitController.text, _cardNumberController.text);
    _refreshJournals();
  }

  // Delete an item
  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a transaction!'),
    ));
    _refreshJournals();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _journals.length,
        itemBuilder: (context, index) => Card(
          color: Colors.blueGrey[200],
          margin: const EdgeInsets.all(15),
          child: ListTile(
              title: Text(_journals[index]['bankName']),
              subtitle: Column(
                  children:[
                    Text(_journals[index]['cardType']),
                    Text(_journals[index]['creditLimit']),
                    Text(_journals[index]['cardNumber']),
                  ]
              ),

              trailing: SizedBox(
                width: 140,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _showForm(_journals[index]['id']),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () =>
                          _deleteItem(_journals[index]['id']),
                    ),
                  ],
                ),
              ),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen())),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showForm(null),
      ),
    );
  }
}
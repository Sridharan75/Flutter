import 'package:flutter/material.dart';
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
    final data = await SQLHelper.getCards();
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

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardNameController = TextEditingController();
  final TextEditingController _creditLimitController = TextEditingController();

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void _showForm(int? cardNumber) async {
    if (cardNumber != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingJournal =
      _journals.firstWhere((element) => element['cardNumber'] == cardNumber);
      _cardNameController.text = existingJournal['cardName'];
      _creditLimitController.text = existingJournal['creditLimit'];
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
                controller: _cardNumberController,
                decoration: const InputDecoration(hintText: 'Card Number last 4 digits'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _cardNameController,
                decoration: const InputDecoration(hintText: 'Card Name'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _creditLimitController,
                decoration: const InputDecoration(hintText: 'Credit Limit'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  // Save new journal
                  if (cardNumber == null) {
                    await _addCard();
                  }

                  if (cardNumber != null) {
                    await _updateCard(cardNumber);
                  }

                  // Clear the text fields
                  _cardNumberController.text = '';
                  _cardNameController.text = '';
                  _creditLimitController.text = '';

                  // Close the bottom sheet
                  Navigator.of(context).pop();
                },
                child: Text(cardNumber == null ? 'Create New' : 'Update'),
              )
            ],
          ),
        ));
  }


// Insert a new journal to the database
  Future<void> _addCard() async {
    await SQLHelper.createCard(
        _cardNumberController.text,_cardNameController.text,_creditLimitController.text);
    _refreshJournals();
  }

  // Update an existing journal
  Future<void> _updateCard(int cardNumber) async {
    await SQLHelper.updateCard(
        _cardNumberController.text,_cardNameController.text,_creditLimitController.text);
    _refreshJournals();
  }

  // Delete an item
  void _deleteCard(int cardNumber) async {
    await SQLHelper.deleteCard(cardNumber);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a journal!'),
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
            color: Colors.orange[200],
            margin: const EdgeInsets.all(15),
            child: ListTile(
                title: Text(_journals[index]['cardNumber']),
                subtitle: Column(
                    children:[
                      Text(_journals[index]['cardName']),
                      Text(_journals[index]['creditLimit']),
                    ]
                ),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _showForm(_journals[index]['cardNumber']),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () =>
                            _deleteCard(_journals[index]['cardNumber']),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showForm(null),
      ),
    );
  }
}
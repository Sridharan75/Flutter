import 'package:flutter/material.dart';
import 'package:credit_card_manage_2/sql_helper.dart';

class transaction extends StatefulWidget {
  const transaction({Key? key}) : super(key: key);

  @override
  State<transaction> createState() => _transactionState();
}

class _transactionState extends State<transaction> {
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

  final TextEditingController _transactionNameController = TextEditingController();
  final TextEditingController _transactionAmountController = TextEditingController();
  final TextEditingController _transactionTypeController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void _showForm(int? id) async {
    if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingJournal =
          _journals.firstWhere((element) => element['id'] == id);
      _transactionNameController.text = existingJournal['transactionName'];
      _transactionAmountController.text = existingJournal['transactionAmount'];
      _transactionTypeController.text = existingJournal['transactionType'];
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
                    controller: _transactionNameController,
                    decoration: const InputDecoration(hintText: 'Transaction Name'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _transactionAmountController,
                    decoration: const InputDecoration(hintText: 'Transaction Type(Purchase/Refund)'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _transactionTypeController,
                    decoration: const InputDecoration(hintText: 'Transaction Amount'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _cardNumberController,
                    decoration: const InputDecoration(hintText: 'Card Number'),
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
                      _transactionNameController.text = '';
                      _transactionAmountController.text = '';
                      _transactionTypeController.text = '';
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
        _transactionNameController.text, _transactionAmountController.text, _transactionTypeController.text, _cardNumberController.text);
    _refreshJournals();
  }

  // Update an existing journal
  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
        id, _transactionNameController.text, _transactionAmountController.text,_transactionTypeController.text, _cardNumberController.text);
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
                    title: Text(_journals[index]['transactionName']),
                    subtitle: Column(
                      children:[
                        Text(_journals[index]['transactionAmount']),
                        Text(_journals[index]['transactionType']),
                        Text(_journals[index]['cardNumber']),
                      ]
                    ),
                    trailing: SizedBox(
                      width: 100,
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

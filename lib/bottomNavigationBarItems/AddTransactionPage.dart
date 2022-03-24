import 'package:flutter/material.dart';

class AddTransactionPage extends StatelessWidget {
  late String _transName;
  late String _transType;
  late String _selectCard;
  late String _transAmount;
  late String _description;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Form(
          key: _formkey,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Transaction Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Transaction Name is Required';
                  }
                },
                onSaved: (value) {
                  _transName = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Transaction Type',
                  prefixIcon: Icon(Icons.transfer_within_a_station),
                  hintStyle: TextStyle(color: Colors.blueGrey),
                  labelStyle: TextStyle(color: Colors.blueGrey),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Transaction Type is Required';
                  }
                },
                onSaved: (value) {
                  _transType = value!;
                },
              ),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Select Card',
                  prefixIcon: Icon(Icons.credit_card_rounded),
                  hintStyle: TextStyle(color: Colors.blueGrey),
                  labelStyle: TextStyle(color: Colors.blueGrey),
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Select Card is Required';
                  }
                },
                onSaved: (value) {
                  _selectCard = value!;
                },
              ),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Transaction Amount',
                  prefixIcon: Icon(Icons.monetization_on_rounded),
                  hintStyle: TextStyle(color: Colors.blueGrey),
                  labelStyle: TextStyle(color: Colors.blueGrey),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Transaction Amount is Required';
                  }
                },
                onSaved: (value) {
                  _transAmount = value!;
                },
              ),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Date',
                  prefixIcon: Icon(Icons.calendar_month),
                  hintStyle: TextStyle(color: Colors.blueGrey),
                  labelStyle: TextStyle(color: Colors.blueGrey),
                ),
                validator: (value) {
                  return;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintStyle: TextStyle(color: Colors.blueGrey),
                  labelStyle: TextStyle(color: Colors.blueGrey),
                ),
                validator: (value) {
                  return;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),

              const SizedBox(height: 20),
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
                onPressed: () {
                  if (!_formkey.currentState!.validate()) {
                    print('valid!');
                  } else {
                    print('invalid!');
                  }
                },
                // onPressed: () {
                //   if(!_formkey.currentState!.validate()){
                //     return;
                //   }
                //
                //   _formkey.currentState!.save();
                //
                //   // Add button ekeng Output eka kohedha yanda oni kiyala methana dhanna.
                //
                // },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

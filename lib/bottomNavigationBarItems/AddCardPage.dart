import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class AddCardPage extends StatelessWidget {
  late String _bName;
  late String _cName;
  late String _cNum;
  late String _exMY;
  late String _cType;


  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Input Card")),
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Bank Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name is Required';
                  }
                },
                onSaved: (value) {
                  _bName = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Card Name',hintText: 'A custom name to identify your card.'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Card Name is Required';
                  }
                },
                onSaved: (value) {
                  _cName = value!;
                },
              ),

              TextFormField(
                decoration: const InputDecoration(labelText: 'Card Type',hintText: 'VISA/Master/American Express'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Card Type is Required';
                  }
                },
                onSaved: (value) {
                  _cType = value!;
                },
              ),

              TextFormField(
                decoration: const InputDecoration(labelText: 'Card Number',hintText: 'Last 4 digit of Card Number'),
                keyboardType: TextInputType.number,
                maxLength: 4,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Card Number is Required';
                  }
                },
                onSaved: (value) {
                  _cNum = value!;
                },
              ),

              TextFormField(
                decoration: const InputDecoration(labelText: 'Expired Date',hintText: 'MM:YY'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Date is Required';
                  }
                },
                onSaved: (value) {
                  _exMY = value!;
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
                    'Add Card',
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

import 'package:flutter/material.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({Key? key}) : super(key: key);

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  late String _bName;
  late String _cName;
  late String _cNum;
  late String _exMY;
  late Object _cType;
  late String _cLimit;

  String dropdownvalue = 'Visa';

  // List of items in our dropdown menu
  var items = [
    'Visa',
    'Master',
    'American Express',
  ];

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20.0),
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

                const SizedBox(height: 20),

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

                const SizedBox(height: 20),

                DropdownButtonFormField(
                  value: dropdownvalue,
                  icon: const Icon(Icons.keyboard_arrow_down_sharp),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },

                  validator: (value) => value == null ? 'Card Type is Required' : null,

                  onSaved: (value) {
                    _cType = value!;
                  },
                ),

                const SizedBox(height: 20),

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

                const SizedBox(height: 20),

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

                TextFormField(
                  decoration: const InputDecoration(labelText: 'Credit Limit',hintText: '(LKR)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Credit Limit is Required';
                    }
                  },
                  onSaved: (value) {
                    _cLimit = value!;
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
                    if (_formkey.currentState!.validate()) {
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
      )
    );
  }
}



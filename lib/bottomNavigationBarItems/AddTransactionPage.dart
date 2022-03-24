import 'package:flutter/material.dart';
class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({Key? key}) : super(key: key);

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {

  late String _transName;
  late Object _transType;
  late String _selectCard;
  late String _transAmount;
  late String _transDate;
  late String _description;
  late Object _cType;

  DateTime date = DateTime.now();

  String ctypevalue = 'Visa';
  String trantypevalue = 'Credit (-)';

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20.0),
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

                const SizedBox(height: 20),

                DropdownButtonFormField(
                  value: trantypevalue,
                  icon: const Icon(Icons.keyboard_arrow_down_sharp),
                  decoration: const InputDecoration(labelText: 'Transaction Type',
                    hintStyle: TextStyle(color: Colors.blueGrey),
                    labelStyle: TextStyle(color: Colors.blueGrey),
                  ),
                  items: <String>['Credit (-)', 'Refund (+)']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      trantypevalue = newValue!;
                    });
                  },

                  validator: (value) => value == null ? 'Card Type is Required' : null,

                  onSaved: (value) {
                    _transType = value!;
                  },
                ),

                const SizedBox(height: 20),

                DropdownButtonFormField(
                  value: ctypevalue,
                  icon: const Icon(Icons.keyboard_arrow_down_sharp),
                  decoration: const InputDecoration(
                    labelText: 'Card Type',
                    hintStyle: TextStyle(color: Colors.blueGrey),
                    labelStyle: TextStyle(color: Colors.blueGrey),
                  ),
                  items: <String>['Visa',
                    'Master',
                    'American Express']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      ctypevalue = newValue!;
                    });
                  },

                  validator: (value) => value == null ? 'Card Type is Required' : null,

                  onSaved: (value) {
                    _cType = value!;
                  },
                ),

                const SizedBox(height: 20),

                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Transaction Amount',hintText: '(LKR.)',
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

                const SizedBox(height: 20),

                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Date',
                    prefixIcon: Icon(Icons.calendar_month),
                    hintStyle: TextStyle(color: Colors.blueGrey),
                    labelStyle: TextStyle(color: Colors.blueGrey),
                  ),
                  initialValue: "${date.year}/${date.month}/${date.day}",
                  validator: (value) {
                    return;
                  },

                  onTap: () async {
                    DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime(1999),
                      lastDate: DateTime(2050),
                    );
                    // if 'Cancel' => null
                    if (newDate == null) return;

                    // if 'Cancel' => null
                    setState(() => date = newDate);
                  },

                  onSaved: (value) {
                    _transDate = value!;
                  },
                ),

                const SizedBox(height: 20),

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
      )
    );
  }
}


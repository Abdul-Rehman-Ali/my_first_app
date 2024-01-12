import 'package:flutter/material.dart';

class PaymentMethod extends StatefulWidget {
  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  String selectedOption = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Foodieflix',
          ),
          backgroundColor: const Color.fromRGBO(253, 141, 20, 800),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(70),
                      bottomRight: Radius.circular(70),
                    ),
                    border: Border.all(color: Colors.orange, width: 3.0),
                  ),
                  child: const Center(
                    child: Text(
                      'Your Payment Method',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                _buildOption('Cash on Delivery'),
                const SizedBox(height: 10.0),
                _buildOption('Other'),
                const SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () {
                    // Handle the 'Done' button press
                    if (selectedOption.isNotEmpty) {
                      print('Selected Payment Method: $selectedOption');
                    } else {
                      print('Please select a payment method');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(253, 141, 20, 800),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOption(String optionText) {
    return Row(
      children: [
        Radio(
          value: optionText,
          groupValue: selectedOption,
          onChanged: (String? value) {
            setState(() {
              selectedOption = value!;
            });
          },
          activeColor: const Color.fromRGBO(253, 141, 20, 800),
        ),
        Text(
          optionText,
          style: const TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}

void main() {
  runApp(PaymentMethod());
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_first_app/sign_in.dart';

class Cart extends StatefulWidget {
  final Map<String, dynamic> cartItem;

  String userId = UserData.userId;
  String userName = UserData.userName;
  String userAddress = UserData.userAddress;

  Cart({Key? key, required this.cartItem}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  String? selectedPaymentMethod;
  bool isPlacingOrder = false;

  get currentCount => null;

  get userName => UserData.userName;
  get userAddress => UserData.userAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Foodieflix',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(253, 141, 20, 800),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Table(
              columnWidths: const {
                0: FlexColumnWidth(1.0),
                1: FlexColumnWidth(2.0),
                2: FlexColumnWidth(1.5),
                3: FlexColumnWidth(1.0),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                const TableRow(
                  decoration: BoxDecoration(
                    color: Colors.orange,
                  ),
                  children: [
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'No.',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Product',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Quantity',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Size',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const TableCell(
                      child: Center(
                        child: Text(
                          '1',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Text(
                          '${widget.cartItem['productName']}',
                          style: const TextStyle(
                            color: Colors.black, // Set text color to black
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Text(
                          '${widget.cartItem['quantity']}',
                          style: const TextStyle(
                            color: Colors.black, // Set text color to black
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Text(
                          '${widget.cartItem['size']}',
                          style: const TextStyle(
                            color: Colors.black, // Set text color to black
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16), // Add some space between the containers

            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(253, 141, 20, 800),
                borderRadius: BorderRadius.circular(15.0),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Amount:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${widget.cartItem['totalPrice'].toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16), // Add some space between the containers

            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(15.0),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      _showPaymentMethodDialog(context);
                    },
                    child: const Text(
                      'Select Payment Method',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (selectedPaymentMethod != null)
                    Text(
                      'Selected Payment Method: $selectedPaymentMethod',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(253, 141, 20, 800),
                borderRadius: BorderRadius.circular(15.0),
              ),
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () {
                  // Save order details to the database
                  _placeOrder();
                },
                child: const Center(
                  child: Text(
                    'Order Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showPaymentMethodDialog(BuildContext context) async {
    String? selectedPaymentMethod;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Payment Method'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: const Text('Cash on Delivery'),
                    leading: Radio(
                      value: 'Cash on Delivery',
                      groupValue: selectedPaymentMethod,
                      onChanged: (String? value) {
                        setState(() {
                          selectedPaymentMethod = value;
                        });
                      },
                    ),
                  ),
                  // ListTile(
                  //   title: const Text('Other'),
                  //   leading: Radio(
                  //     value: 'Other',
                  //     groupValue: selectedPaymentMethod,
                  //     onChanged: (String? value) {
                  //       setState(() {
                  //         selectedPaymentMethod = value;
                  //       });
                  //     },
                  //   ),
                  // ),
                ],
              );
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedPaymentMethod != null) {
                  // Handle the selected payment method
                  print('Selected Payment Method: $selectedPaymentMethod');
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }

  void _placeOrder() async {
    setState(() {
      isPlacingOrder = true;
    });

    // Get the current date and time
    DateTime now = DateTime.now();
    String formattedDate = "${now.day}-${now.month}-${now.year}";
    String formattedTime = "${_formatTime(now)}";

    String userId =
        UserData.userId; // Get the user ID from your authentication system

    CollectionReference ordersCollection =
        FirebaseFirestore.instance.collection('orders');

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentReference countDocRef =
          FirebaseFirestore.instance.collection('counters').doc('ordersCount');

      DocumentSnapshot countDoc = await transaction.get(countDocRef);
      int currentCount = countDoc.exists ? countDoc['count'] : 0;

      await transaction.set(
        countDocRef,
        {'count': currentCount + 1},
      );

      await ordersCollection.doc((currentCount + 1).toString()).set({
        'username': userName,
        'user_id': userId,
        'p_name': widget.cartItem['productName'],
        'p_quantity': widget.cartItem['quantity'],
        'p_size': widget.cartItem['size'],
        't_price': widget.cartItem['totalPrice'],
        'user_add': userAddress,
        'date': formattedDate, // Store the current date
        'time': formattedTime, // Store the current time
      });

      return currentCount + 1; // Return the updated count
    }).then((newCount) {
      print('Order saved to database with document ID: $newCount');
      setState(() {
        isPlacingOrder = false;
      });
      _showOrderSuccessDialog();
    }).catchError((error) {
      print('Failed to save order: $error');
      // Handle error, show an error message, etc.
      setState(() {
        isPlacingOrder = false;
      });
    });
  }

  String _formatTime(DateTime dateTime) {
    String period = dateTime.hour < 12 ? 'AM' : 'PM';
    int hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    String minute =
        dateTime.minute < 10 ? '0${dateTime.minute}' : '${dateTime.minute}';
    return '$hour:$minute $period';
  }

  void _showOrderSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Order Placed Successfully'),
          content: const Text('Your order has been placed successfully!'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

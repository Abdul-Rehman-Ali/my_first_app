import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'cart.dart';

void main() {
  runApp(Burger(
    collectionName: 'your_collection_name',
    documentId: 'your_document_id',
  ));
}

class Burger extends StatefulWidget {
  final String collectionName;
  final String documentId;

  Burger({required this.collectionName, required this.documentId});

  @override
  _Burger createState() => _Burger();
}

class _Burger extends State<Burger> {
  int quantity = 0;
  double totalPrice = 0.0;
  late String productName = '';
  late String productDescription = '';
  late String productImage = '';
  late double price = 0.0;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPizzaDetails();
  }

  Future<void> _fetchPizzaDetails() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection(widget.collectionName)
          .doc(widget.documentId)
          .get();

      await Future.delayed(Duration(seconds: 1));

      if (snapshot.exists) {
        setState(() {
          productName = snapshot.data()?['Name'] ?? '';
          productDescription = snapshot.data()?['Description'] ?? '';
          productImage = snapshot.data()?['image_1'] ?? '';
          price = (snapshot.data()?['Price'] ?? 0.0).toDouble();

          isLoading = false;
        });
      } else {
        print('Document does not exist');
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print('Error fetching pizza details: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  void updateTotalPrice() {
    totalPrice = quantity * price;
  }

  void addToCart() {
    if (quantity <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a quantity greater than 0.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    Map<String, dynamic> cartItem = {
      'productName': productName,
      'quantity': quantity,
      'totalPrice': totalPrice,
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Cart(cartItem: cartItem),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Foodieflex',
          ),
          backgroundColor: const Color.fromRGBO(253, 141, 20, 800),
        ),
        key: scaffoldKey,
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                  strokeWidth:
                      10.0, // Set the stroke width for a greater radius
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
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
                        child: Center(
                          child: Text(
                            productName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.network(
                          productImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        child: const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 250,
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(bottom: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.orange[100],
                        ),
                        child: Text(
                          productDescription,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Quantity",
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  if (quantity > 0) {
                                    quantity--;
                                    updateTotalPrice();
                                  }
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.orange[200],
                              ),
                              child: Center(
                                child: Text(
                                  '$quantity',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                  updateTotalPrice();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 60,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.orange[200],
                        ),
                        child: Center(
                          child: Text(
                            'Price \$${price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 60,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.orange[200],
                        ),
                        child: Center(
                          child: Text(
                            'Your total = \$${totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          addToCart();
                        },
                        child: Container(
                          height: 70,
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Add to Cart',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

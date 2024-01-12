import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'burger.dart';
import 'favourite_page.dart';

class fries_category extends StatefulWidget {
  @override
  _fries_category createState() => _fries_category();
}

class _fries_category extends State<fries_category> {
  late Future<List<Item>> pizzaItems;

  @override
  void initState() {
    super.initState();
    pizzaItems = _fetchCakeItems();
  }

  Future<List<Item>> _fetchCakeItems() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('Fries_category').get();

    return snapshot.docs.map((doc) {
      return Item(
        image: doc['image'],
        name: doc['Name'],
        price: doc['Price'].toString(),
      );
    }).toList();
  }

  void _onItemTap(String itemName) {
    switch (itemName) {
      case 'Simple Fries':
        _navigateToBurger('Fries_category', 'item_1');
        break;
      case 'Loaded Fries':
        _navigateToBurger('Fries_category', 'item_2');
        break;
      case 'Cheese Fries':
        _navigateToBurger('Fries_category', 'item_3');
        break;
      case 'Pizza Fries':
        _navigateToBurger('Fries_category', 'item_4');
        break;
      case 'Masala Fries':
        _navigateToBurger('Fries_category', 'item_5');
        break;
      default:
        _navigateToBurger('Fries_category', 'item_6');
        break;
    }
  }

  void _navigateToBurger(String collectionName, String documentId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Burger(
          collectionName: collectionName,
          documentId: documentId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Foodieflex'),
          backgroundColor: const Color.fromRGBO(253, 141, 20, 800),
        ),
        body: FutureBuilder<List<Item>>(
          future: pizzaItems,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    _buildItemRow(snapshot.data!),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildItemRow(List<Item> items) {
    List<Widget> rows = [];

    for (int i = 0; i < items.length; i += 2) {
      List<Item> rowItems = items.sublist(i, i + 2);
      rows.add(_buildRow(rowItems));
    }

    return Column(
      children: rows,
    );
  }

  Widget _buildRow(List<Item> items) {
    return Row(
      children: items
          .map((item) => Expanded(
                child: GestureDetector(
                  onTap: () => _onItemTap(item.name),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orange[50],
                        border: Border.all(color: Colors.orange),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          const Padding(
                              padding: EdgeInsets.fromLTRB(0, 15, 0, 10)),
                          CircleAvatar(
                            backgroundImage: NetworkImage(item.image),
                            backgroundColor: Colors.orange[50],
                            radius: 60,
                          ),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                          Text(
                            item.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 10)),
                          Text('\$${item.price}'),
                          const SizedBox(
                            height: 10,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     const Padding(
                          //         padding: EdgeInsets.fromLTRB(10, 0, 10, 0)),
                          //     Text('\$${item.price}'),
                          //     GestureDetector(
                          //       onTap: () {
                          //         Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //               builder: (context) => favourite_page()),
                          //         );
                          //       },
                          //       child: const Icon(Icons.favorite_border,
                          //           color: Colors.grey),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}

class Item {
  final String image;
  final String name;
  final String price;

  Item({
    required this.image,
    required this.name,
    required this.price,
  });
}

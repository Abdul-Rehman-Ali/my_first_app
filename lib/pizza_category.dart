import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_first_app/cheesy_pizza.dart';
import 'package:my_first_app/periPeri_pizza.dart';
import 'package:my_first_app/veggie_pizza.dart';
import 'bbq_pizza.dart';
import 'chicken_fajita_pizza.dart';
import 'chicken_tikka_pizza.dart';
import 'favourite_page.dart';

class pizza_category extends StatefulWidget {
  @override
  _pizza_categoryState createState() => _pizza_categoryState();
}

class _pizza_categoryState extends State<pizza_category> {
  late Future<List<Item>> pizzaItems;

  @override
  void initState() {
    super.initState();
    pizzaItems = _fetchPizzaItems();
  }

  Future<List<Item>> _fetchPizzaItems() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('Pizza_category').get();

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
      case 'Chicken Fajita':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChickenFajitaPizza()),
        );
        break;
      case 'Chicken Tikka':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => chickenTikkaPizza()),
        );
        break;
      case 'Cheesy Pizza':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => cheesy_Pizza()),
        );
        break;
      case 'BBQ Pizza':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => bbq_Pizza()),
        );
        break;
      case 'Veggie Pizza':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => veggie_Pizza()),
        );
        break;
      default:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => periPeri_Pizza()),
        );
        break;
    }
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

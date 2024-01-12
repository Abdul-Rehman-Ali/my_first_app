import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class my_order extends StatefulWidget {
  final String userId;

  my_order({required this.userId});

  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<my_order> {
  late Future<List<Order>> orders;

  @override
  void initState() {
    super.initState();
    orders = fetchOrders();
  }

  Future<List<Order>> fetchOrders() async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('orders')
        .where('user_id', isEqualTo: widget.userId)
        .get();

    final List<Order> ordersList = result.docs.map((doc) {
      return Order(
        productName: doc['p_name'],
        productQuantity: doc['p_quantity'],
        productSize: doc['p_size'] ?? 'N/A', // Use 'N/A' if p_size is null
        totalPrice: doc['t_price'],
        date: doc['date'],
        time: doc['time'],
      );
    }).toList();

    return ordersList;
  }

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
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: FutureBuilder(
            future: orders,
            builder: (context, AsyncSnapshot<List<Order>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<Order> ordersList = snapshot.data!;
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Product Name')),
                      DataColumn(label: Text('Quantity')),
                      DataColumn(label: Text('Size')),
                      DataColumn(label: Text('Total Price')),
                      DataColumn(label: Text('Date')),
                      DataColumn(label: Text('Time')),
                    ],
                    rows: ordersList
                        .map((order) => DataRow(cells: [
                              DataCell(Text(order.productName)),
                              DataCell(Text(order.productQuantity.toString())),
                              DataCell(Text(order.productSize)),
                              DataCell(Text(order.totalPrice.toString())),
                              DataCell(Text(order.date)),
                              DataCell(Text(order.time)),
                            ]))
                        .toList(),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class Order {
  final String productName;
  final int productQuantity;
  final String productSize;
  final double totalPrice;
  final String date;
  final String time;

  Order({
    required this.productName,
    required this.productQuantity,
    required this.productSize,
    required this.totalPrice,
    required this.date,
    required this.time,
  });
}

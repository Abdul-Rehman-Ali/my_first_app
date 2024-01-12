import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AllOrders(),
    );
  }
}

class AllOrders extends StatefulWidget {
  @override
  _AllOrdersState createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  late Future<List<Map<String, dynamic>>> orders;
  TextEditingController searchController = TextEditingController();
  String selectedFilter = 'orderNo';

  @override
  void initState() {
    super.initState();
    orders = fetchOrders(orderBy: 'username'); // Initial sorting by username
  }

  Future<List<Map<String, dynamic>>> fetchOrders(
      {String orderBy = 'username', String? searchValue}) async {
    CollectionReference<Map<String, dynamic>> collection =
        FirebaseFirestore.instance.collection('orders');

    if (searchValue != null && searchValue.isNotEmpty) {
      QuerySnapshot<Map<String, dynamic>> result;

      if (orderBy == 'date' || orderBy == 'orderNo') {
        if (orderBy == 'date') {
          // Check if the search value is a date
          DateTime? searchDate = _parseDate(searchValue);
          if (searchDate != null) {
            // Convert the DateTime to a Timestamp for Firestore comparison
            Timestamp startDate = Timestamp.fromDate(searchDate);
            Timestamp endDate =
                Timestamp.fromDate(searchDate.add(Duration(days: 1)));

            result = await collection
                .where('date', isGreaterThanOrEqualTo: startDate)
                .where('date', isLessThan: endDate)
                .get();
          } else {
            // If not a valid date, perform a regular search
            result =
                await collection.where(orderBy, isEqualTo: searchValue).get();
          }
        } else {
          // Searching by order ID
          int? orderNumber = int.tryParse(searchValue);

          if (orderNumber != null) {
            DocumentSnapshot<Map<String, dynamic>> docSnapshot =
                await collection.doc(searchValue).get();

            Map<String, dynamic> data = docSnapshot.data() ?? {};
            data['order_no'] =
                docSnapshot.id; // Use document ID as order number
            return [data];
          } else {
            // If not a valid number, assume it's a document ID
            DocumentSnapshot<Map<String, dynamic>> docSnapshot =
                await collection.doc(searchValue).get();

            Map<String, dynamic> data = docSnapshot.data() ?? {};
            data['order_no'] =
                docSnapshot.id; // Use document ID as order number
            return [data];
          }
        }
      } else {
        // Regular search for other fields
        result = await collection
            .where(selectedFilter, isEqualTo: searchValue)
            .get();
      }

      return result.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
        Map<String, dynamic> data = doc.data() ?? {};
        data['order_no'] = doc.id; // Use document ID as order number
        return data;
      }).toList();
    }

    QuerySnapshot<Map<String, dynamic>> result =
        await collection.orderBy(orderBy).get();

    return result.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
      Map<String, dynamic> data = doc.data() ?? {};
      data['order_no'] = doc.id; // Use document ID as order number
      return data;
    }).toList();
  }

  DateTime? _parseDate(String date) {
    try {
      List<String> parts = date.split('-');
      int day = int.tryParse(parts[0]) ?? 1;
      int month = int.tryParse(parts[1]) ?? 1;
      int year = int.tryParse(parts[2]) ?? 2000;
      return DateTime(year, month, day);
    } catch (e) {
      return null;
    }
  }

  void searchOrders() {
    String searchValue = searchController.text.trim();
    setState(() {
      orders = fetchOrders(orderBy: selectedFilter, searchValue: searchValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Foodieflix - All Orders'),
          backgroundColor: const Color.fromRGBO(253, 141, 20, 800),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Search Orders'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: searchController,
                            decoration: const InputDecoration(
                              labelText: 'Search value',
                            ),
                          ),
                          SizedBox(height: 10),
                          DropdownButton<String>(
                            value: selectedFilter,
                            items: [
                              DropdownMenuItem(
                                value: 'orderNo',
                                child: Text('Order ID'),
                              ),
                              DropdownMenuItem(
                                value: 'username',
                                child: Text('Username'),
                              ),
                              DropdownMenuItem(
                                value: 'p_name',
                                child: Text('Product Name'),
                              ),
                              DropdownMenuItem(
                                value: 'date',
                                child: Text('Date'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedFilter = value!;
                              });
                            },
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            searchOrders();
                            Navigator.of(context).pop();
                          },
                          child: Text('Search'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      'All Orders',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: orders,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        final List<Map<String, dynamic>> orderData =
                            snapshot.data ?? [];

                        return DataTable(
                          columns: [
                            DataColumn(label: Text('Order No.')),
                            DataColumn(label: Text('Username')),
                            DataColumn(label: Text('User ID')),
                            DataColumn(label: Text('Product Name')),
                            DataColumn(label: Text('Product Quantity')),
                            DataColumn(label: Text('Product Size')),
                            DataColumn(label: Text('Total Price')),
                            DataColumn(label: Text('Date')),
                            DataColumn(label: Text('Time')),
                            DataColumn(label: Text('User Address')),
                          ],
                          rows: orderData.map((order) {
                            return DataRow(
                              cells: [
                                DataCell(Text(order['order_no'].toString())),
                                DataCell(Text(order['username'].toString())),
                                DataCell(Text(order['user_id'].toString())),
                                DataCell(Text(order['p_name'].toString())),
                                DataCell(Text(order['p_quantity'].toString())),
                                DataCell(Text(order['p_size'].toString())),
                                DataCell(Text(order['t_price'].toString())),
                                DataCell(Text(order['date'].toString())),
                                DataCell(Text(order['time'].toString())),
                                DataCell(Text(order['user_add'].toString())),
                              ],
                            );
                          }).toList(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

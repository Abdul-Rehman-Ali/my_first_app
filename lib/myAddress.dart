import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_first_app/sign_in.dart';

class myAddress extends StatefulWidget {
  @override
  _myAddress createState() => _myAddress();
}

class _myAddress extends State<myAddress> {
  // Default user information
  String userAddress = '';

  // Method to update user information
  void updateUserInformation(String newAddress) {
    setState(() {
      userAddress = newAddress;
    });
  }

  Future<String> fetchUserAddressFromDatabase(
      String userId, String userEmail) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      return userDoc['address'] ?? '';
    } catch (e) {
      print('Error fetching user address: $e');
      return '';
    }
  }

  // Function to fetch user address
  Future<void> fetchUserAddress() async {
    String fetchedAddress =
        await fetchUserAddressFromDatabase(UserData.userId, UserData.userEmail);
    updateUserInformation(fetchedAddress);
  }

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Address'),
          content: TextField(
            controller: TextEditingController(text: userAddress),
            onChanged: (newAddress) {
              userAddress = newAddress;
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                saveNewAddressToDatabase(userAddress);
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> saveNewAddressToDatabase(String newAddress) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(UserData.userId)
          .update({'address': newAddress});

      updateUserInformation(newAddress);
    } catch (e) {
      print('Error updating user address: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserAddress();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Address'),
          backgroundColor: const Color.fromRGBO(253, 141, 20, 800),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Your Address',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _showEditDialog();
                        },
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 10),
                Container(
                  child: Text(
                    userAddress,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
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

void main() {
  runApp(myAddress());
}

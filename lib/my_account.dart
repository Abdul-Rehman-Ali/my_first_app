import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_first_app/favourite_page.dart';
import 'package:my_first_app/page2.dart';
import 'package:my_first_app/payment_method.dart';
import 'package:my_first_app/sign_in.dart';
import 'change_password.dart';
import 'myAddress.dart';
import 'my_order.dart';

class my_account extends StatefulWidget {
  @override
  _my_account createState() => _my_account();
}

class _my_account extends State<my_account> {
  // Default user information
  String userName = UserData.userName;
  String phoneNumber = UserData.userPhoneNumber;
  String email = UserData.userEmail;
  String userId = UserData.userId;
  String userAddress = UserData.userId;

  // Method to update user information
  void updateUserInformation(String newName, String newPhoneNumber) {
    setState(() {
      userName = newName;
      phoneNumber = newPhoneNumber;
    });
  }

  Future<void> saveUpdatedUserDataToDatabase(
      String newUserName, String newPhoneNumber) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(UserData.userId)
          .update({
        'username': newUserName,
        'phone': newPhoneNumber,
      });

      // Update the UI with the new user information
      updateUserInformation(newUserName, newPhoneNumber);
    } catch (e) {
      print('Error updating user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Account'),
          backgroundColor: const Color.fromRGBO(253, 141, 20, 800),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('asset/images/profile.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              userName,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _showEditDialog(
                                  'Edit Name',
                                  userName,
                                  (newName) {
                                    saveUpdatedUserDataToDatabase(
                                      newName,
                                      phoneNumber,
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              phoneNumber,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _showEditDialog(
                                  'Edit Phone Number',
                                  phoneNumber,
                                  (newPhoneNumber) {
                                    saveUpdatedUserDataToDatabase(
                                      userName,
                                      newPhoneNumber,
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  'Personal',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    const Icon(
                      Icons.shopping_bag,
                      size: 25,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => my_order(userId: userId),
                          ),
                        );
                      },
                      child: const Text(
                        'My Order',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 25,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => myAddress(),
                          ),
                        );
                      },
                      child: const Text(
                        'My Address',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    const Icon(
                      Icons.favorite,
                      size: 25,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => favourite_page(),
                          ),
                        );
                      },
                      child: const Text(
                        'My Favourite',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    const Icon(
                      Icons.payment,
                      size: 25,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentMethod(),
                          ),
                        );
                      },
                      child: const Text(
                        'Payment Method',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  'General',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    const Icon(
                      Icons.password,
                      size: 25,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => change_password(),
                          ),
                        );
                      },
                      child: const Text(
                        'Change Password',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    const Icon(
                      Icons.logout,
                      size: 25,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Page2(),
                          ),
                        );
                      },
                      child: const Text(
                        'Log Out',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEditDialog(
    String title,
    String initialValue,
    Function(String) onSave,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newValue = initialValue;

        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: TextEditingController(text: initialValue),
            onChanged: (value) {
              newValue = value;
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                onSave(newValue);
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(my_account());
}

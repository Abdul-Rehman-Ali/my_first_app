import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_first_app/page2.dart';

import 'home.dart';

class drawer extends StatefulWidget {
  @override
  _drawer createState() => _drawer();
}

class _drawer extends State<drawer> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.orange,
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'asset/images/food_logo.png',
                        height: 100.0,
                        width: 120.0,
                      ),
                    ),
                    const Text(
                      'Food Delivery App',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ));
                    },
                    child: const ListTile(
                      title: Text('Home'),
                      leading: Icon(Icons.home),
                    ),
                  ),
                  const ListTile(
                    title: Text('Account'),
                    leading: Icon(Icons.account_circle),
                  ),
                  const ListTile(
                    title: Text('My Cart'),
                    leading: Icon(Icons.shopping_cart),
                  ),
                  const ListTile(
                    title: Text('Coctact'),
                    leading: Icon(Icons.contact_phone),
                  ),
                  const ListTile(
                    title: Text('Favourite'),
                    leading: Icon(Icons.favorite),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Page2(),
                          ));
                    },
                    child: const ListTile(
                      title: Text('Log Out'),
                      leading: Icon(Icons.logout),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

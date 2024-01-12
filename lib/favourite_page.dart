import 'dart:io';
import 'package:flutter/material.dart';

class favourite_page extends StatefulWidget {
  @override
  _favourite_page createState() => _favourite_page();
}

class _favourite_page extends State<favourite_page> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Your Favorite',
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: Colors.orange,
        ),
      ),
    );
  }
}

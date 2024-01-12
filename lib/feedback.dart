import 'dart:io';
import 'package:flutter/material.dart';

class feedback extends StatefulWidget {
  @override
  _feedback createState() => _feedback();
}

class _feedback extends State<feedback> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Feedback',
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: Colors.orange,
        ),
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image(
                image: AssetImage('asset/images/feedback.png'),
              ),
            ),
            Text(
              'Customer feedback is the secret',
              style: TextStyle(
                color: Colors.orange,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'ingredient to our success',
              style: TextStyle(
                color: Colors.orange,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Share your thought at:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'support@foodieflix.com',
              style: TextStyle(
                color: Colors.orange,
                fontSize: 20.0,
                // fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '0318 1646340',
              style: TextStyle(
                color: Colors.orange,
                fontSize: 20.0,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

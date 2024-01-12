import 'dart:io';
import 'package:flutter/material.dart';

class contact_us extends StatefulWidget {
  @override
  _contact_us createState() => _contact_us();
}

class _contact_us extends State<contact_us> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Contact Us',
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
                image: AssetImage('asset/images/contactus.png'),
              ),
            ),
            Text(
              'Support Center',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'For quries please contact us at:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                // fontWeight: FontWeight.bold,
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
              height: 25,
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

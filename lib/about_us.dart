import 'dart:io';
import 'package:flutter/material.dart';

class about_us extends StatefulWidget {
  @override
  _about_us createState() => _about_us();
}

class _about_us extends State<about_us> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'About Us',
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
                image: AssetImage('asset/images/about1.jpeg'),
              ),
            ),
            Image(
              image: AssetImage('asset/images/about2.png'),
            ),
            Text(
              '"Picture a team of food fanatics 🍔🥑,',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '  tech wizards 💻🔮, and delivery',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'daredevils 🚀🚴 coming together to',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              ' revolutionize your dining experience 🍽️💫.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                // fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              ' Thats the heart and soul of FoodieFlix 💓."',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

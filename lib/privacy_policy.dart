import 'dart:io';
import 'package:flutter/material.dart';

class privacy_policy extends StatefulWidget {
  @override
  _privacy_policy createState() => _privacy_policy();
}

class _privacy_policy extends State<privacy_policy> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Privacy Policy',
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: Colors.orange,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(70),
                          bottomRight: Radius.circular(70)),
                      border: Border.all(color: Colors.orange, width: 3.0)),
                  child: const Center(
                    child: Text(
                      'Foodieflix Policy',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: const Text(
                      'Welcome to Foodieflix, your favorite food delivery app! We take your privacy seriously and want you to feel comfortable while using our service. This Privacy Policy explains how we collect, use, and protect your personal information. By using Foodieflix, you agree to the terms outlined below.',
                      style: TextStyle(
                        fontSize: 18,
                      )),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: const Text('1. Information We Collect',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange)),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: const Text(
                      'We collect the following types of information:\nPersonal Information: This includes your name, email address, phone number, and delivery address.\nOrder Information: Details about the food orders you place through Foodieflix, such as items, payment, and delivery preferences.\nLocation Data: We may collect your location data to provide you with accurate delivery times and nearby restaurant recommendations.\nDevice Information: Information about the device you use to access Foodieflix, such as device type and operating system.',
                      style: TextStyle(
                        fontSize: 18,
                      )),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: const Text('2. How We Use Your Information',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      )),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: const Text(
                      'We use your information for the following purposes:\nTo provide food delivery and customer support services.\nTo improve and personalize your Foodieflix experience.\nTo send you updates, promotions, and important notifications.\nTo enhance app security and prevent fraudulent activities.',
                      style: TextStyle(
                        fontSize: 18,
                      )),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: const Text('3. Sharing Your Information',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      )),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: const Text(
                      'We share your information only with the necessary parties to provide our services, such as restaurants and delivery drivers. We do not sell your personal information to third parties.',
                      style: TextStyle(
                        fontSize: 18,
                      )),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: const Text('4. Your Choices',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      )),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: const Text(
                      'You can manage your personal information and privacy settings within the app. You can opt out of promotional emails and push notifications.',
                      style: TextStyle(
                        fontSize: 18,
                      )),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: const Text('5. Security',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      )),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: const Text(
                      'We use industry-standard security measures to protect your information. However, no method is 100% secure, so we cannot guarantee absolute security.',
                      style: TextStyle(
                        fontSize: 18,
                      )),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: const Text('6. Changes to this Policy',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: const Text(
                      'We may update this Privacy Policy as needed. We will notify you of any significant changes.',
                      style: TextStyle(
                        fontSize: 18,
                      )),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: const Text('7. Contact Us',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: const Text(
                      'If you have questions or concerns about your privacy on Foodieflix, please contact us at \n0318 1646340.\nThank you for choosing Foodieflix, and we hope you enjoy your delicious food deliveries while knowing your privacy is important to us!',
                      style: TextStyle(
                        fontSize: 18,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

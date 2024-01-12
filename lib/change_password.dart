import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_first_app/sign_up.dart';
// import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

import 'forget_pass.dart';
// import 'first_page.dart';

class change_password extends StatefulWidget {
  @override
  _change_password createState() => _change_password();
}

class _change_password extends State<change_password> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool _isPasswordHidden = true; // Variable to control password visibility
  bool _isConfirmPasswordHidden = true;
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              // // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 80.0),
                  child: const Center(
                    child: Text(
                      'Change Password',
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 80.0),
                  child: const Center(
                    child: Text(
                      'Please enter your password for update',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          obscureText: _isPasswordHidden,
                          controller: passwordController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            hintText: 'Enter Old Password',
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isPasswordHidden =
                                      !_isPasswordHidden; // Toggle the visibility
                                });
                              },
                              icon: Icon(
                                _isPasswordHidden
                                    ? Icons.remove_red_eye_sharp
                                    : Icons.remove_red_eye_outlined,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 8) {
                              return 'Password must be at least 8 characters long';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          obscureText: _isConfirmPasswordHidden,
                          controller: confirmPasswordController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            hintText: 'Enter New Password',
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isConfirmPasswordHidden =
                                      !_isConfirmPasswordHidden; // Toggle the visibility
                                });
                              },
                              icon: Icon(
                                _isConfirmPasswordHidden
                                    ? Icons.remove_red_eye_sharp
                                    : Icons.remove_red_eye_outlined,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 8) {
                              return 'Password must be at least 8 characters long';
                            }
                            if (value == passwordController.text) {
                              return "Please Enter Different New Password";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              // Perform Reset Password logic here
                              // You can access form values using the controllers
                              // For example: usernameController.text, emailController.text, etc.
                            }
                          },
                          child: Container(
                            // height: 100.0,
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.orange,
                            ),
                            child: const Center(
                              child: Text(
                                'Done',
                                style: TextStyle(
                                  color: Colors.white,
                                  backgroundColor: Colors.orange,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 130.0,
                          margin: EdgeInsets.fromLTRB(0, 100, 120, 0),
                          child: const Image(
                            image: AssetImage('asset/images/login1.png'),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:my_first_app/prac.dart';
import 'package:my_first_app/reset_password.dart';

class Varification_Password extends StatefulWidget {
  @override
  _Varification_Password createState() => _Varification_Password();
}

class _Varification_Password extends State<Varification_Password> {
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
                  margin: EdgeInsets.fromLTRB(0, 100, 0, 20),
                  child: const Center(
                    child: Text(
                      'Varification',
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 80.0),
                  child: const Center(
                    child: Text(
                      'Please enter the code you received',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                OtpTextField(
                  numberOfFields: 4,
                  fillColor: Colors.black.withOpacity(0.1),
                  filled: true,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 15.0,
                    ),
                    const Row(
                      children: [
                        Text(
                          "Don't received the code?                            ",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        TextButton(
                          onPressed: null,
                          child: Text(
                            'Resend',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Reset_Password(),
                          ),
                        );
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
                            'Send',
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
                      margin: const EdgeInsets.fromLTRB(0, 70, 120, 0),
                      child: const Image(
                        image: AssetImage('asset/images/login1.png'),
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
}

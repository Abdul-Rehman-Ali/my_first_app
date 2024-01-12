import 'package:flutter/material.dart';
import 'package:my_first_app/varification_pass.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Forget_Password extends StatefulWidget {
  @override
  _Forget_Password createState() => _Forget_Password();
}

class _Forget_Password extends State<Forget_Password> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  String errorMessage = '';

  Future<void> _sendPasswordResetEmail() async {
    try {
      bool isEmailRegistered = await _isEmailRegistered(emailController.text);

      if (isEmailRegistered) {
        setState(() {
          errorMessage = ''; // Clear any previous error message
        });

        // Get the correct password from Firebase for the given email
        String correctPassword =
            await _getCorrectPassword(emailController.text);

        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: correctPassword,
        );

        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController.text,
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Varification_Password()),
        );
      } else {
        setState(() {
          errorMessage = 'Email not registered. Please enter a valid email.';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: ${e.toString()}';
      });
    }
  }

  Future<bool> _isEmailRegistered(String email) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: 'dummyPassword', // Provide a dummy password
      );

      // If sign-in is successful, return true
      return true;
    } catch (e) {
      // If sign-in fails, return false
      return false;
    }
  }

  Future<String> _getCorrectPassword(String email) async {
    // In a real-world scenario, you would fetch the correct password
    // associated with the email from your database (e.g., Firebase Firestore).

    // For now, let's assume the correct password is 'correctPassword'
    return 'correctPassword';
  }

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
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 100, 0, 20),
                  child: const Center(
                    child: Text(
                      'Forget Password',
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 100.0),
                  child: const Center(
                    child: Text(
                      'Please enter your email; we will help you\n'
                      '               to change your password',
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
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: 'Your Email',
                          border: OutlineInputBorder(),
                          errorText:
                              errorMessage.isNotEmpty ? errorMessage : null,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      InkWell(
                        onTap: () async {
                          setState(() {
                            errorMessage = '';
                          });

                          if (_formKey.currentState!.validate()) {
                            await _sendPasswordResetEmail();
                          }
                        },
                        child: Container(
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

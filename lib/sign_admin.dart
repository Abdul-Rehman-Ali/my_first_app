import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'all_orders.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignInAdmin(),
    );
  }
}

class SignInAdmin extends StatefulWidget {
  @override
  _SignInAdmin createState() => _SignInAdmin();
}

class _SignInAdmin extends State<SignInAdmin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isPasswordHidden = true;
  String _errorMessage = '';

  Future<void> _signIn() async {
    if (!EmailValidator.validate(emailController.text)) {
      setState(() {
        _errorMessage = 'Invalid email. Please enter a valid email address.';
      });
      return;
    }

    if (emailController.text == 'chabdulrehman1039@gmail.com' &&
        passwordController.text == 'Csma1039') {
      // Successful login
      // You can add more data if needed
      UserData.userId = 'custom_user_id';
      UserData.userName = 'Custom User';
      UserData.userEmail = emailController.text;

      // Navigate to the home page or any other page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AllOrders(),
        ),
      );
    } else {
      // Incorrect email or password
      setState(() {
        _errorMessage = 'Incorrect email or password. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Foodieflix'),
          backgroundColor: const Color.fromRGBO(253, 141, 20, 800),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 80.0),
                  child: const Center(
                    child: Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 60.0),
                  child: const Center(
                    child: Text(
                      'Admin Account',
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
                      if (_errorMessage.isNotEmpty)
                        Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            _errorMessage,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: 'Email',
                          border: OutlineInputBorder(),
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
                      TextFormField(
                        obscureText: _isPasswordHidden,
                        controller: passwordController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: 'Enter Password',
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isPasswordHidden = !_isPasswordHidden;
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
                      InkWell(
                        onTap: () {
                          setState(() {
                            _errorMessage = '';
                          });
                          if (_formKey.currentState!.validate()) {
                            _signIn();
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
                              'Login',
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserData {
  static String userId = '';
  static String userName = '';
  static String userEmail = '';
}

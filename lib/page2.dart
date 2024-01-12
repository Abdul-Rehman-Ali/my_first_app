import 'package:flutter/material.dart';
import 'package:my_first_app/sign_in.dart';
import 'package:my_first_app/sign_up.dart';
// import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class Page2 extends StatefulWidget {
  @override
  _Page2 createState() => _Page2();
}

class _Page2 extends State<Page2> {
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
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: ListView(
            children: [
              Container(
                height: 270,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('asset/images/img.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignIn(),
                      ));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 40.0),
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Center(
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUp(),
                      ));
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: const Divider(
                  height: 10.0,
                  thickness: 0.3,
                  color: Colors.black,
                  indent: 0,
                  endIndent: 140,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 190.0,
                ),
                child: const Text(
                  'Or Follow Us',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () async {
                      final url = Uri.parse(
                          'https://www.linkedin.com/in/abdul-rehman-ali-124523223');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(210, 5, 15, 0),
                      child: const CircleAvatar(
                        backgroundImage: AssetImage('asset/images/fb.png'),
                        backgroundColor: Colors.orange,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final url = Uri.parse('https://www.instagram.com/');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                        print('clicked');
                      }
                    },
                    child: Container(
                      // margin: const EdgeInsets.fromLTRB(210, 5, 5, 0),
                      child: const CircleAvatar(
                        backgroundImage:
                            AssetImage('asset/images/instagram.jpg'),
                        backgroundColor: Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 130.0,
                margin: EdgeInsets.fromLTRB(0, 0, 120, 0),
                child: const Image(
                  image: AssetImage('asset/images/login1.png'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

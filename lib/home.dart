import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_first_app/burger_category.dart';
import 'package:my_first_app/cake_category.dart';
import 'package:my_first_app/drinks_category.dart';
import 'package:my_first_app/favourite_page.dart';
import 'package:my_first_app/fries_category.dart';
import 'package:my_first_app/ice_cream_category.dart';
import 'package:my_first_app/page2.dart';
import 'package:my_first_app/pasta_category.dart';
import 'package:my_first_app/pizza_category.dart';
import 'package:my_first_app/popular_now.dart';
import 'package:my_first_app/privacy_policy.dart';
import 'package:my_first_app/sandwich_category.dart';
import 'package:my_first_app/sign_admin.dart';
import 'about_us.dart';
import 'burger.dart';
import 'contact_us.dart';
import 'feedback.dart';
import 'my_account.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _current = 0;
  bool _isViewAll = false;

  final List<String> imgList = [
    'asset/images/home_page_slider/img1.jpg',
    'asset/images/home_page_slider/img2.jpg',
    'asset/images/home_page_slider/img3.jpg',
    'asset/images/home_page_slider/img4.jpg',
    'asset/images/home_page_slider/img5.jpg',
  ];

  final List<Map<String, String>> foodCategories = [
    {'image': 'asset/images/home_category_img/burger.png', 'name': 'Burgers'},
    {
      'image': 'asset/images/home_category_img/pizza_slice.png',
      'name': 'Pizza'
    },
    {'image': 'asset/images/home_category_img/drink.png', 'name': 'Drinks'},
    {'image': 'asset/images/home_category_img/cake.png', 'name': 'Cakes'},
  ];

  final List<Map<String, String>> nextFoodCategories = [
    {
      'image': 'asset/images/home_category_img/sandwich.png',
      'name': 'Sandwich'
    },
    {'image': 'asset/images/home_category_img/ice.png', 'name': 'Ice Cream'},
    {'image': 'asset/images/home_category_img/fries.png', 'name': 'Fries'},
    {'image': 'asset/images/home_category_img/pasta.png', 'name': 'Pasta'},
  ];

  late Future<List<Item>> popularItems;

  @override
  void initState() {
    super.initState();
    popularItems = _fetchPopularItems();
  }

  Future<List<Item>> _fetchPopularItems() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('Popular_category').get();

      return snapshot.docs.map((doc) {
        return Item(
          image: doc['image'],
          name: doc['Name'],
          price: doc['Price'].toString(),
        );
      }).toList();
    } catch (e) {
      print('Error fetching popular items: $e');
      return [];
    }
  }

  void _onItemTap(String itemName) {
    switch (itemName) {
      case 'Double Cheese':
        _navigateToBurger('Burger_category', 'item_1');
        break;
      case 'Butter Scotch':
        _navigateToBurger('Cake_category', 'item_5');
        break;
      case 'Grilled Sandwich':
        _navigateToBurger('Sandwich_category', 'item_6');
        break;
      default:
        _navigateToBurger('Drink_category', 'item_5');
        break;
    }
  }

  void _navigateToBurger(String collectionName, String documentId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Burger(
          collectionName: collectionName,
          documentId: documentId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Foodieflix',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange,
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.orange,
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'asset/images/food_logo.png',
                      height: 100.0,
                      width: 120.0,
                    ),
                  ),
                  const Text(
                    'Food Delivery App',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ));
                  },
                  child: const ListTile(
                    title: Text('Home'),
                    leading: Icon(Icons.home),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => my_account(),
                        ));
                  },
                  child: const ListTile(
                    title: Text('Account'),
                    leading: Icon(Icons.account_circle),
                  ),
                ),
                // InkWell(
                //   onTap: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => favourite_page(),
                //         ));
                //   },
                //   child: const ListTile(
                //     title: Text('Favourite'),
                //     leading: Icon(Icons.favorite),
                //   ),
                // ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => contact_us(),
                        ));
                  },
                  child: const ListTile(
                    title: Text('Coctact Us'),
                    leading: Icon(Icons.contact_phone),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => feedback(),
                        ));
                  },
                  child: const ListTile(
                    title: Text('Feedback'),
                    leading: Icon(Icons.feedback),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => about_us(),
                        ));
                  },
                  child: const ListTile(
                    title: Text('About Us'),
                    leading: Icon(Icons.feed_outlined),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => privacy_policy(),
                        ));
                  },
                  child: const ListTile(
                    title: Text('Privacy Policy'),
                    leading: Icon(Icons.privacy_tip),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignInAdmin(),
                        ));
                  },
                  child: const ListTile(
                    title: Text('Administration'),
                    leading: Icon(Icons.admin_panel_settings),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Page2(),
                        ));
                  },
                  child: const ListTile(
                    title: Text('Log Out'),
                    leading: Icon(Icons.logout),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10.0),
                child: CarouselSlider(
                  items: imgList.map((item) {
                    return Image.asset(
                      item,
                      fit: BoxFit.cover,
                      width: 260,
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 200,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 2),
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imgList.map((url) {
                  int index = imgList.indexOf(url);
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? const Color.fromRGBO(253, 141, 20, 0.9)
                          : const Color.fromRGBO(0, 0, 0, 0.4),
                    ),
                  );
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Category',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isViewAll = !_isViewAll;
                      });
                    },
                    child: const Text('View All',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.orange,
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _buildCategoryRow(foodCategories),
              if (_isViewAll) ...[
                const SizedBox(height: 10),
                _buildCategoryRow(nextFoodCategories),
              ],
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Popular Now',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PopularNowContent(),
                        ),
                      );
                    },
                    child: const Text('more',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.orange,
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildPopularItemsSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryRow(List<Map<String, String>> categories) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: categories.map((category) {
        return GestureDetector(
          onTap: () => _onCategoryTap(category['name']!),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(category['image']!),
                  backgroundColor: Colors.red,
                  radius: 30,
                ),
                const SizedBox(height: 10),
                Text(
                  category['name']!,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPopularItemsSection() {
    return FutureBuilder<List<Item>>(
      future: popularItems,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return Column(
            children: [
              _buildItemRow(snapshot.data!.take(4).toList()),
            ],
          );
        } else {
          return Container(); // Handle the case when there is no data
        }
      },
    );
  }

  Widget _buildItemRow(List<Item> items) {
    List<Widget> rows = [];

    for (int i = 0; i < items.length; i += 2) {
      List<Item> rowItems = items.sublist(i, i + 2);
      rows.add(_buildRow(rowItems));
    }

    return Column(
      children: rows,
    );
  }

  Widget _buildRow(List<Item> items) {
    return Row(
      children: items
          .map((item) => Expanded(
                child: GestureDetector(
                  onTap: () => _onItemTap(item.name),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orange[50],
                        border: Border.all(color: Colors.orange),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          const Padding(
                              padding: EdgeInsets.fromLTRB(0, 15, 0, 10)),
                          CircleAvatar(
                            backgroundImage: NetworkImage(item.image),
                            backgroundColor: Colors.orange[50],
                            radius: 60,
                          ),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                          Text(
                            item.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 10)),
                          Text('\$${item.price}'),
                          const SizedBox(
                            height: 10,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     const Padding(
                          //         padding: EdgeInsets.fromLTRB(10, 0, 10, 0)),
                          //     Text('\$${item.price}'),
                          //     GestureDetector(
                          //       onTap: () {
                          //         Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //               builder: (context) => favourite_page()),
                          //         );
                          //       },
                          //       child: const Icon(Icons.favorite_border,
                          //           color: Colors.grey),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }

  void _onCategoryTap(String categoryName) {
    switch (categoryName) {
      case 'Burgers':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => burger_category()));
        break;
      case 'Pizza':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => pizza_category()));
        break;
      case 'Drinks':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => drink_category()));
        break;
      case 'Cakes':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => cake_category()));
        break;
      case 'Sandwich':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => sandwich_category()));
        break;
      case 'Ice Cream':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ice_cream_category()));
        break;
      case 'Fries':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => fries_category()));
        break;
      default:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => pasta_category()));
        break;
    }
  }
}

class PopularNowContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This widget is used for the "more" button to navigate to popular items
    return popular_now();
  }
}

class Item {
  final String image;
  final String name;
  final String price;

  Item({
    required this.image,
    required this.name,
    required this.price,
  });
}

void main() {
  runApp(const MyApp());
}

import 'package:apollo/configdata/color_codes.dart';
import 'package:apollo/screens/cartpage.dart';
import 'package:apollo/screens/homepage.dart';
import 'package:apollo/screens/loginpage.dart';
import 'package:apollo/screens/orderpage.dart';

import 'package:apollo/screens/profilepage.dart';
import 'package:apollo/screens/searchpage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  final List pages = [
    const HomePage(),
    const SearchPage(),
    const OrderPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: myAppBar(),
      ),
      backgroundColor: themeColor,
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.amber,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (value) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          var token = prefs.getString('jwt_token');
          if ((value == 2 || value == 3) && token == null) {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => LoginPage()));
          } else {
            setState(() {
              selectedIndex = value;
            });
          }
        },
        elevation: 0,
        backgroundColor: themeColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Tìm kiếm"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Đơn hàng"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Tôi"),
        ],
      ),
      body: pages[selectedIndex],
    );
  }

  Widget myAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.person,
            color: Colors.black,
          ),
          Image.asset('assets/images/logo.png'),
          Stack(
            children: [
              GestureDetector(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  var token = prefs.getString('jwt_token');
                  if (token == null) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => LoginPage()));
                  } else {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => CartPage()));
                  }
                },
                child: Icon(
                  Icons.shopping_bag_outlined,
                  size: 28,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

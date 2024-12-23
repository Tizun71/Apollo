import 'package:apollo/configdata/color_codes.dart';
import 'package:apollo/screens/homepage.dart';
import 'package:apollo/screens/profilepage.dart';
import 'package:apollo/screens/searchpage.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 3;
  final List pages = [
    const HomePage(),
    const SearchPage(),
    const Scaffold(),
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
        onTap: (value) {
          setState(() {});
          selectedIndex = value;
        },
        elevation: 0,
        backgroundColor: themeColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Tìm kiếm"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active), label: "Thông báo"),
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
            color: Colors.white,
          ),
          Image.asset('assets/images/logo.png'),
          Stack(
            children: [
              Icon(
                Icons.shopping_bag_outlined,
                size: 28,
                color: Colors.white,
              ),
              Positioned(
                  right: 0,
                  top: -5,
                  child: Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                    child: Center(
                      child: Text(
                        "3",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }
}

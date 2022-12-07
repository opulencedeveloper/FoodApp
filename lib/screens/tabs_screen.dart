import 'package:flutter/material.dart';

import "./favourite_tab_screen.dart";
import "./orders_screen.dart";
import "./home_page.dart";
import "./profile_screen.dart";

class TabsScreen extends StatefulWidget {
  static const routeName = "/tabs-screen";
  const TabsScreen({Key? key}) : super(key: key);
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Widget> _pages = [
    const HomePage(),
    const FavouriteTabScreen(),
    const OrdersScreen(),
    const ProfileScreen()
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        //currentIndex: 2,
        onTap: _selectPage,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Theme.of(context).primaryColor,
        currentIndex: _selectedPageIndex,
        // type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(
            //backgroundColor: Theme.of(context).colorScheme.secondary, //works with BottomNavigationBarType.shifting, above
            icon: Icon(Icons.home_filled),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: "Bookmark",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

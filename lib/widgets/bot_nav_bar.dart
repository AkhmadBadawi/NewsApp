import 'package:flutter/material.dart';
import 'package:flutter_helloword/tampilan/account_screen.dart';
import 'package:flutter_helloword/tampilan/discover_screen.dart';
import 'package:flutter_helloword/tampilan/home_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key?key,
    required this.index,
    }) : super(key: key);

    final int index;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black.withAlpha(100),

      items: [
        BottomNavigationBarItem(
            icon: Container(
              margin: const EdgeInsets.only(left: 50),
              child: IconButton(onPressed: () {
                Navigator.pushReplacementNamed(context, HomeScreen.routeName);
              },
              icon: const Icon(Icons.home)
              ),
            ), label: 'Home',
        ),

        BottomNavigationBarItem(
            icon: IconButton(onPressed: () {
                Navigator.pushReplacementNamed(context, DiscoverScreen.routeName);
            },
            icon: const Icon(Icons.search)
            ), label: 'Search',
        ),

        BottomNavigationBarItem(
            icon: Container(
              margin: const EdgeInsets.only(right: 50),
              child: IconButton(onPressed: () {
                Navigator.pushReplacementNamed(context, AccountScreen.routeName);
              },
              icon: const Icon(Icons.person_4_outlined)
              ),
            ), label: 'Profile',
        ),

      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_helloword/tampilan/account_screen.dart';

import 'tampilan/article_screen.dart';
import 'tampilan/discover_screen.dart';
import 'tampilan/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News App UI ',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        initialRoute: '/',
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          DiscoverScreen.routeName: (context) => const DiscoverScreen(searchController: null),
          ArticleScreen.routeName: (context) => const ArticleScreen(),
          AccountScreen.routeName: (context) => const AccountScreen(),
        });
  }
}

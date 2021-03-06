import 'package:flutter/material.dart';
import './screens/pages/about_us_page.dart';
import './screens/pages/head_line_page.dart';
import './screens/pages/news_list_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pages = [HeadLinePage(), NewsListPage(), AboutUsPage()];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: const Icon(Icons.highlight),
                  title: const Text('トップニュース')),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.list), title: const Text('ニュース一覧')),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.info), title: const Text('このアプリについて')),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            }),
      ),
    );
  }
}

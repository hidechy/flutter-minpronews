import 'package:flutter/material.dart';
import './view/home_screen.dart';
import './view/style/styles.dart';

import 'package:provider/provider.dart';

//import './viewmodels/news_list_viewmodel.dart';
//import './viewmodels/head_line_viewmodel.dart';
//import 'models/db/database.dart';

import './di/providers.dart';

//MyDatabase myDatabase;

void main() {
//  myDatabase = MyDatabase();

  runApp(MultiProvider(
    /*
    providers: [
      ChangeNotifierProvider(
        create: (_) => NewsListViewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => HeadLineViewModel(),
      ),
    ],
    */

    providers: globalProviders,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NewsFeed',
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: ReqularFont,
      ),
      home: HomeScreen(),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beerrecord/screen/dictionary_screen.dart';
import 'package:flutter_beerrecord/screen/home_screen.dart';
import 'package:flutter_beerrecord/screen/login_screen.dart';
import 'package:flutter_beerrecord/screen/search_screen.dart';
import 'widget/bottom_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beer Memory',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: DefaultTabController(
        length: 4,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Love.png'),
              fit: BoxFit.cover
            )
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                HomeScreen(),
                DictionaryScreen(),
                SearchScreen(),
                Container(child: Center(child: Text('더보기'),),),
              ],
            ),
            bottomNavigationBar: BottomBar(),
          ),
        ),
      ),
    );
  }
}


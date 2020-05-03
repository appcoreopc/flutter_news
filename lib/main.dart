import 'package:flutter/material.dart';
import 'newscategories/newscategories.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'News Reader',
      theme: ThemeData(          
        primaryColor: Colors.lightBlue,
      ), 
      home: Scaffold(
        appBar: AppBar(
          title: Text('News Reader'),
        ),
        body: Center(
          child: NewsCategories(),
        ),
      ),
    );
  }
}



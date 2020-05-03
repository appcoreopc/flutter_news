import 'package:flutter/material.dart';
import 'features/newscategories/newscategories.dart';
import 'appconstant.dart' as AppConstant;

void main() => runApp(NewsReaderApp());

class NewsReaderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: AppConstant.ApplicationName,
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text(AppConstant.ApplicationName),
            ),
            body: SafeArea(child: Center(child: NewsCategories()))));
  }
}

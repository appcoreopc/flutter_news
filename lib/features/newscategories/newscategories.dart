import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hello/models/newscategorymodel.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../service/httpservice.dart';


class NewsCategories extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewsCategoriesState();
}

class NewsCategoriesState extends State<NewsCategories> {
  Future<List<Article>> _futureNewsData;
  
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();


  final TextStyle _titleFont =
      TextStyle(fontSize: 20.0, color: Colors.black.withOpacity(0.8));

  final TextStyle _contentFont =
      TextStyle(fontSize: 16.0, color: Colors.black.withOpacity(0.8));

  @override
  void initState() {
    super.initState();
    _futureNewsData = NewsDataService().fetchNewsCategories();
  }

  @override
  Widget build(BuildContext context) {

    _futureNewsData = NewsDataService().fetchNewsCategories();

    return Scaffold(
        body: FutureBuilder<List<Article>>(
          future: _futureNewsData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _buildNewsData(snapshot.data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return CircularProgressIndicator();
          },
        ),
        backgroundColor: Colors.black);
  }

  Widget _buildNewsData(List<Article> newsData) {
    return ListView.builder(
        itemCount: newsData.length,
        padding: const EdgeInsets.all(12.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          return _buildRow(newsData[i]);
        });
  }

  Widget _buildRow(Article newsData) {
    return Ink(
      child: ListTile(
        title: Text(newsData.title, style: _titleFont),
        subtitle: Padding(
            padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
            child: Text(newsData.content, style: _contentFont)),
        trailing: Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
        onTap: () {
          _pushNewsCategory(newsData);
        },
      ),
      color: Colors.grey,
    );
  }

  void _pushNewsCategory(Article newsData) {


    // Navigator.of(context).push(
    //   MaterialPageRoute<void>(
    //       builder: (BuildContext context) => DetailNewsPage(newsData)),
    // );
  }
}

class DetailNewsPage extends StatelessWidget {
  Article _article;
  final TextStyle _biggerFont = TextStyle(fontSize: 18.0);

  DetailNewsPage(this._article);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_article.title),
      ),
      body: _buildNewsData(_article),
    );
  }

  Widget _buildNewsData(Article newsData) {
    return _buildRow(newsData);
  }

  Widget _buildRow(Article newsData) {
    final TextStyle _biggerFont = TextStyle(fontSize: 18.0);
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(newsData.title, overflow: TextOverflow.clip),
            ),
            Expanded(child: Text(newsData.content)),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text('BUY TICKETS'),
                  onPressed: () {/* ... */},
                ),
                FlatButton(
                  child: Text('LISTEN'),
                  onPressed: () {/* ... */},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

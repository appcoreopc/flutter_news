import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:hello/models/newscategorymodel.dart';
import '../../service/httpservice.dart';

class NewsCategories extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewsCategoriesState();
}

class NewsCategoriesState extends State<NewsCategories> {
  Future<List<Article>> data;
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>(); // Add this line.
  final TextStyle _biggerFont =
      TextStyle(fontSize: 18.0, color: Colors.white.withOpacity(0.8));

  @override
  void initState() {
    super.initState();
    data = NewsDataService().fetchNewsCategories();
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    data = NewsDataService().fetchNewsCategories();

    return Scaffold(
        // body: _buildSuggestions(),
        body: FutureBuilder<List<Article>>(
          future: data,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _buildSuggestions();
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return CircularProgressIndicator();
          },
        ),
        backgroundColor: Colors.black);
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(14.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {

    final bool alreadySaved = _saved.contains(pair);

    return Ink(
      child: ListTile(
        title: Text(
          pair.asPascalCase,
          style: _biggerFont),
        trailing: Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null,
        ),
        onTap: () {
          setState(() {
            if (alreadySaved) {
              _saved.remove(pair);
            } else {
              _saved.add(pair);
            }
          });
        },
      ),
      color: Colors.grey,
    );
  }

  void _pushNewsCategory() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
          builder: (BuildContext context) => SaveList(_saved)),
    );
  }
}

class SaveList extends StatelessWidget {
  Set<WordPair> _saved = Set<WordPair>();
  final TextStyle _biggerFont = TextStyle(fontSize: 18.0);
  SaveList(this._saved);

  @override
  Widget build(BuildContext context) {
    final Iterable<ListTile> tiles = _saved.map(
      (WordPair pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
          onTap: () => AlertDialog(),
        );
      },
    );

    // final List<Widget> divided = ListTile.divideTiles(
    //   context: context,
    //   tiles: tiles,
    // ).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Suggestions'),
      ),
      //body: ListView(children: divided),
    );
  }
}

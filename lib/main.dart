import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont = TextStyle(fontSize: 18.0);

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      final titles = _saved.map((WordPair pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
        );
      });
      final divided = ListTile.divideTiles(
        context: context,
        tiles: titles,
      ).toList();

      return Scaffold(
        appBar: AppBar(
          title: Text('Saved Suggestions'),
        ),
        body: ListView(
          children: divided,
        ),
      );
    }));
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(alreadySaved ? Icons?.favorite : Icons?.favorite_border,
          color: alreadySaved ? Colors.red : null),
      onTap: () {
        setState(() {
          alreadySaved ? _saved.remove(pair) : _saved.add(pair);
        });
      },
    );
  }

  Widget _buildSuggestion() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          //For odd rows, the function adds a Divider widget to visually separate the entries.
          if (i.isOdd) return Divider();

          //  The expression i ~/ 2 divides i by 2 and returns an integer result.
          //  For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
          //  This calculates the actual number of word pairings in the ListView, minus the divider widgets.
          final index = i ~/ 2;

          // If you’ve reached the end of the available word pairings,
          // then generate 10 more and add them to the suggestions list.
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup New Generator'),
        actions: [
          IconButton(
            icon: Icon(Icons?.list),
            onPressed: _pushSaved,
          )
        ],
      ),
      body: _buildSuggestion(),
    );
  }
}

//Main class
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Welcome to flutter',
        theme: ThemeData(primaryColor: Colors.blue),
        home: RandomWords());
  }
}

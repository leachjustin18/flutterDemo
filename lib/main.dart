import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = TextStyle(fontSize: 18.0);

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
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
      ),
      body: _buildSuggestion(),
    );
  }
}

//Main class
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Welcome to flutter', home: RandomWords());
  }
}

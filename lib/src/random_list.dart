import 'dart:io';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RandomListState();
}

class _RandomListState extends State<RandomList> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    final randomWord = WordPair.random();

    return Scaffold(
      appBar: AppBar(
        title: Text("naming app"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: (){

            },
          )
        ],
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return ListView.builder(itemBuilder: (context, index) {
      // 0, 2, 4, 6, 8... = real items
      // 1, 3, 5, 7, 9... = dividers
      if (index.isOdd) {
        return Divider();
      }

      var realIndex = index ~/ 2; // ~/ 몫을 return

      if (realIndex >= _suggestions.length) {
        _suggestions.addAll(generateWordPairs().take(10));
      }
      return _buildRow(_suggestions[realIndex]);
    });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        textScaleFactor: 1.5,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: Colors.pink,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved)
            _saved.remove(pair); //true
          else
            _saved.add(pair); //false

          print(_saved.toString());
          // print(pair.asPascalCase);
        });
      },
    );
  }
}

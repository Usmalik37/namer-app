import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var history = <WordPair>[];
  var favorites = <WordPair>[];

  void getNextRandomWord() {
    history.insert(0, current);
    if (history.length > 25) {
      history.removeLast();
    }
    current = WordPair.random();
    notifyListeners();
  }

  void restoreFromHistory(WordPair pair) {
    history.remove(pair);
    history.insert(0, current);
    current = pair;
    notifyListeners();
  }

  void toggleFavorite([WordPair? pair]) {
    final target = pair ?? current;
    if (favorites.contains(target)) {
      favorites.remove(target);
    } else {
      favorites.add(target);
    }
    notifyListeners();
  }

  void removeFavorite(WordPair pair) {
    favorites.remove(pair);
    notifyListeners();
  }
}

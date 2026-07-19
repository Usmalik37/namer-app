import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNextRandomWord() {
    current = WordPair.random();
    notifyListeners();
  }

  // tells flutter that only wordpair is allowed in the array (change to set {} later)
  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }

    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {


    Widget page;
switch (selectedIndex) {
  case 0:
    page = GeneratorPage();
    break;
  case 1:
    page = FavoritePage();
    break;
  default:
    throw UnimplementedError('no widget for $selectedIndex');
}


    return Scaffold(
      body: Row(
        children: [
          SafeArea(
            child: NavigationRail(
              extended: false,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite),
                  label: Text('Favorites'),
                ),
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child:page,
            ),
          ),
        ],
      ),
    );
  }
}


  class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});
  


  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var favoriteList = appState.favorites;
    if(favoriteList.isEmpty){
      return Center(child: Text('No favorites yet'));
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text("You have ${appState.favorites.length} favorites"),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: favoriteList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.favorite_rounded),
                title: Text(favoriteList[index].asLowerCase),
              );
            },
          ),
        ),
      ],
    );
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;
    IconData iconFavorite;

    if (appState.favorites.contains(pair)) {
      iconFavorite = Icons.favorite;
    } else {
      iconFavorite = Icons.favorite_border;
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PairCard(pair: pair),
          SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                label: Text("Like"),
                onPressed: appState.toggleFavorite,
                icon: Icon(iconFavorite),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  appState.getNextRandomWord();
                },
                child: Text("Next"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PairCard extends StatelessWidget {
  const PairCard({super.key, required this.pair});

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          pair.asCamelCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}


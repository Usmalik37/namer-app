# Namer App

A simple Flutter application that generates random English word pairs, lets the user favorite the ones they like, and displays them in a list. This project was built as part of learning core Flutter concepts.

## Acknowledgment

This project was built by following **Google's Flutter Codelabs**. It is a learning project created to practice and understand fundamental Flutter concepts, not an original app design.

## What the App Does

- Generates a random word pair using the `english_words` package
- Displays the current word pair on screen
- Lets the user tap a button to generate a new random word pair
- Lets the user add or remove a word pair from their **Favorites** list
- Displays all saved favorites on a separate screen

## Concepts Covered

This app was built to practice the following core Flutter fundamentals:

- **State Management**: using the `provider` package to manage and share app state
- **ListView / List Builder**: dynamically building a list of favorite word pairs
- **Navigation (Navigator / Rails)**: moving between the Home screen and Favorites screen using a Navigation Rail
- **Widgets & Layout**: building UI using Flutter's widget system

## Packages Used

| Package | Purpose |
|---|---|
| `provider` | App-wide state management |
| `english_words` | Generates random English word pairs |

## How State Works

- The app uses a single `ChangeNotifier` class to hold app state
- The current word pair and the list of favorites are stored in this state class
- Favorites are stored as a `List` of word pairs, since each "favorite" is a pair of two words
- Widgets listen to this state and rebuild automatically when it changes

## Branches

| Branch | What it is |
|---|---|
| `main` | This — the original Flutter Codelab tutorial code |
| `my_namer_app` | A fully rebuilt, production-polished version with custom design, modular architecture, and optimized build |

## Project Status

This is a learning project — built to understand Flutter basics, not intended for production use. See the `my_namer_app` branch for the rebuilt version.

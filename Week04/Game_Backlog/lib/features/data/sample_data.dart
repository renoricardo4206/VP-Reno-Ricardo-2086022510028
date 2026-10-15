import '../models/game.dart';


const String kScenario = String.fromEnvironment('SCENARIO');

const List<Game> kDefaultGames = [
  Game(id: 1, title: 'Elden Ring', platform: 'PC', status: GameStatus.playing),
  Game(id: 2, title: 'Hades', platform: 'Switch', status: GameStatus.finished),
  Game(id: 3, title: 'Cyberpunk 2077', platform: 'PC', status: GameStatus.backlog),
  Game(id: 4, title: 'Hollow Knight', platform: 'PC', status: GameStatus.dropped),
  Game(id: 5, title: 'Genshin Impact', platform: 'Mobile', status: GameStatus.playing),
];

/// Judul 200 karakter untuk tes "Long text".
String longTitle() => ('Judul game sangat panjang ' * 8).substring(0, 200);

List<Game> gamesForScenario(String scenario) => switch (scenario) {
      'empty' => <Game>[],
      'long_text' => [
          Game(
            id: 1,
            title: longTitle(),
            platform: ('PC / Steam / Epic / GOG / ' * 8).substring(0, 120),
            status: GameStatus.playing,
          ),
          ...kDefaultGames.skip(1),
        ],
      'long_list' => List<Game>.generate(
          500,
          (i) => Game(
            id: i + 1,
            title: 'Game ${i + 1}',
            platform: const ['PC', 'Switch', 'Mobile'][i % 3],
            status: GameStatus.values[i % GameStatus.values.length],
          ),
        ),
      _ => kDefaultGames,
    };

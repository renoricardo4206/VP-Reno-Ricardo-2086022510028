enum GameStatus { playing, finished, dropped, backlog }

extension GameStatusX on GameStatus {
  String get label => switch (this) {
        GameStatus.playing => 'Playing',
        GameStatus.finished => 'Finished',
        GameStatus.dropped => 'Dropped',
        GameStatus.backlog => 'Backlog',
      };
}

class Game {
  const Game({
    required this.id,
    required this.title,
    required this.platform,
    required this.status,
  });

  final int id;
  final String title;
  final String platform;
  final GameStatus status;

  Game copyWith({GameStatus? status}) => Game(
        id: id,
        title: title,
        platform: platform,
        status: status ?? this.status,
      );
}
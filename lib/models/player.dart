class Player {
  final String id;
  String name;
  int wins;
  int losses;
  int draws;

  Player({
    required this.id,
    required this.name,
    this.wins = 0,
    this.losses = 0,
    this.draws = 0,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'wins': wins,
        'losses': losses,
        'draws': draws,
      };

  factory Player.fromJson(Map<String, dynamic> json) => Player(
        id: json['id'] as String,
        name: json['name'] as String,
        wins: json['wins'] as int? ?? 0,
        losses: json['losses'] as int? ?? 0,
        draws: json['draws'] as int? ?? 0,
      );
}

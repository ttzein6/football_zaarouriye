import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Team {
  int goals;
  String name;
  List<dynamic> players;
  int redCards;
  int yellowCards;
  int points;
  int inGoals;
  int outGoals;
  int wins;
  int loses;
  int draws;

  Team({
    required this.goals,
    required this.name,
    required this.players,
    required this.redCards,
    required this.yellowCards,
    required this.points,
    required this.draws,
    required this.inGoals,
    required this.loses,
    required this.outGoals,
    required this.wins,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'goals': goals,
      'name': name,
      'players': players,
      'redCards': redCards,
      'yellowCards': yellowCards,
      'points': points,
      'inGoals': inGoals,
      'outGoals': outGoals,
      'wins': wins,
      'loses': loses,
      'draws': draws,
    };
  }

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      goals: map['goals'] as int,
      name: map['name'] as String,
      redCards: map['redCards'] as int,
      yellowCards: map['yellowCards'] as int,
      points: map['points'] as int,
      players: List<String>.from(
        (map['players'] as List<dynamic>),
      ),
      draws: map['draws'] as int,
      wins: map['wins'] as int,
      loses: map['loses'] as int,
      inGoals: map['inGoals'] as int,
      outGoals: map['outGoals'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Team.fromJson(String source) =>
      Team.fromMap(json.decode(source) as Map<String, dynamic>);
}

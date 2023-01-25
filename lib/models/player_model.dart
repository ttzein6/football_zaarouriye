// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Player {
  String name;
  String team;
  int redCards;
  int yellowCards;
  int goals;
  Player({
    required this.name,
    required this.team,
    required this.goals,
    required this.redCards,
    required this.yellowCards,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'team': team,
      'redCards': redCards,
      'yellowCards': yellowCards,
      'goals': goals,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      name: map['name'] as String,
      team: map['team'] as String,
      redCards: map['redCards'] as int,
      yellowCards: map['yellowCards'] as int,
      goals: map['goals'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Player.fromJson(String source) =>
      Player.fromMap(json.decode(source) as Map<String, dynamic>);
}

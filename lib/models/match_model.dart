// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Match {
  String id;
  bool played;
  String team1;
  String team2;
  int team1Goals;
  int team2Goals;
  int week;
  Timestamp time;
  Match({
    required this.id,
    required this.played,
    required this.team1,
    required this.team2,
    required this.team1Goals,
    required this.team2Goals,
    required this.week,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'played': played,
      'team1': team1,
      'team2': team2,
      'team1Goals': team1Goals,
      'team2Goals': team2Goals,
      'week': week,
      'time': time
    };
  }

  factory Match.fromMap(Map<String, dynamic> map) {
    return Match(
      id: map['id'] as String,
      played: map['played'] as bool,
      team1: map['team1'] as String,
      team2: map['team2'] as String,
      team1Goals: map['team1Goals'] as int,
      team2Goals: map['team2Goals'] as int,
      week: map['week'] as int,
      time: map['time'] as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  factory Match.fromJson(String source) =>
      Match.fromMap(json.decode(source) as Map<String, dynamic>);
}

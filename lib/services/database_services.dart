import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:nede_fetyen/models/match_model.dart';
import 'package:nede_fetyen/models/player_model.dart';
import 'package:nede_fetyen/models/teams_model.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<Player>?> getPlayersData() async {
    try {
      var doc = await _firestore.collection('players').get();

      List<Player> players = [];
      for (var element in doc.docs) {
        players.add(Player.fromMap(element.data()));
      }
      return players;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<List<Team>?> getTeamsData() async {
    try {
      var doc = await _firestore.collection('teams').get();

      List<Team> teams = [];
      for (var element in doc.docs) {
        log("Teams players : ${element.data()["players"].runtimeType}");
        teams.add(Team.fromMap(element.data()));
      }
      return teams;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<List<Match>?> getMatchesData() async {
    try {
      var doc = await _firestore.collection('matches').get();

      List<Match> matches = [];
      for (var element in doc.docs) {
        matches.add(Match.fromMap(element.data()));
      }
      return matches;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<void> addPlayerGoals(String playerName, int goals) async {
    log("ADDING PLAYER GOALS");
    try {
      await _firestore
          .collection("players")
          .where("name", isEqualTo: playerName)
          .get()
          .then((value) async {
        await value.docs.first.reference.set({
          "name": value.docs.first.data()["name"],
          "team": value.docs.first.data()["team"],
          "goals": (value.docs.first.data()["goals"] + goals),
          "redCards": value.docs.first.data()["redCards"],
          "yellowCards": value.docs.first.data()["yellowCards"]
        }
            // Player(
            //         name: value.docs.first.data()["name"],
            //         team: value.docs.first.data()["team"],
            //         goals: value.docs.first.data()["goals"] + goals,
            //         redCards: value.docs.first.data()["redCards"],
            //         yellowCards: value.docs.first.data()["yellowCards"])
            //     .toMap(),
            ).then((value) {
          log("DONE");
        });
      });
    } catch (e) {
      log("ERROR :::: $e");
      debugPrint(e.toString());
      // rethrow;
    }
  }

  Future<void> addPlayerYellowCards(String playerName, String teamName) async {
    try {
      await _firestore
          .collection("players")
          .where("name", isEqualTo: playerName)
          .get()
          .then((value) {
        value.docs.first.reference
            .set(
          Player(
                  name: value.docs.first.data()["name"],
                  team: value.docs.first.data()["team"],
                  goals: value.docs.first.data()["goals"],
                  redCards: value.docs.first.data()["redCards"],
                  yellowCards: value.docs.first.data()["yellowCards"] + 1)
              .toMap(),
        )
            .then((value) async {
          await _firestore
              .collection("teams")
              .where("name", isEqualTo: teamName)
              .get()
              .then((value) {
            value.docs.first.reference.set(
              Team(
                name: value.docs.first.data()["name"],
                players: value.docs.first.data()["players"],
                goals: value.docs.first.data()["goals"],
                redCards: value.docs.first.data()["redCards"],
                yellowCards: value.docs.first.data()["yellowCards"] + 1,
                points: value.docs.first.data()["points"],
                draws: value.docs.first.data()["draws"],
                inGoals: value.docs.first.data()["inGoals"],
                loses: value.docs.first.data()["loses"],
                outGoals: value.docs.first.data()["outGoals"],
                wins: value.docs.first.data()["wins"],
              ).toMap(),
            );
          });
        });
      });
    } catch (e) {
      debugPrint(e.toString());
      // rethrow;
    }
  }

  Future<void> addPlayerRedCards(String playerName, String teamName) async {
    try {
      await _firestore
          .collection("players")
          .where("name", isEqualTo: playerName)
          .get()
          .then((value) {
        value.docs.first.reference
            .set(
          Player(
                  name: value.docs.first.data()["name"],
                  team: value.docs.first.data()["team"],
                  goals: value.docs.first.data()["goals"],
                  redCards: value.docs.first.data()["redCards"] + 1,
                  yellowCards: value.docs.first.data()["yellowCards"])
              .toMap(),
        )
            .then((value) async {
          await _firestore
              .collection("teams")
              .where("name", isEqualTo: teamName)
              .get()
              .then((value) {
            value.docs.first.reference.set(
              Team(
                name: value.docs.first.data()["name"],
                players: value.docs.first.data()["players"],
                goals: value.docs.first.data()["goals"],
                redCards: value.docs.first.data()["redCards"] + 1,
                yellowCards: value.docs.first.data()["yellowCards"],
                points: value.docs.first.data()["points"],
                draws: value.docs.first.data()["draws"],
                inGoals: value.docs.first.data()["inGoals"],
                loses: value.docs.first.data()["loses"],
                outGoals: value.docs.first.data()["outGoals"],
                wins: value.docs.first.data()["wins"],
              ).toMap(),
            );
          });
        });
      });
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  //TODO
  Future<void> addMatchResult(String matchId, String team1, String team2,
      int team1Goals, int team2Goals) async {
    try {
      await _firestore
          .collection("matches")
          .where("id", isEqualTo: matchId)
          .get()
          .then((value) {
        value.docs.first.reference
            .set(
          Match(
            id: value.docs.first.data()["id"],
            played: true,
            team1: value.docs.first.data()["team1"],
            team2: value.docs.first.data()["team2"],
            team1Goals: team1Goals,
            team2Goals: team2Goals,
            week: value.docs.first.data()["week"],
          ).toMap(),
        )
            .then((value) async {
          int goalsDiff = team1Goals - team2Goals;
          int team1Points = 0;
          int team2Points = 0;
          String result = "draw";
          if (goalsDiff == 0) {
            team1Points = 1;
            team2Points = 1;
          } else if (goalsDiff > 0) {
            team1Points = 3;
            team2Points = 0;
            result = "win";
          } else {
            team1Points = 0;
            team2Points = 3;
            result = "lose";
          }
          await _firestore
              .collection("teams")
              .where("name", isEqualTo: team1)
              .get()
              .then((value) async {
            await value.docs.first.reference
                .set(
              Team(
                name: value.docs.first.data()["name"],
                players: value.docs.first.data()["players"],
                goals: value.docs.first.data()["goals"] + goalsDiff,
                redCards: value.docs.first.data()["redCards"],
                yellowCards: value.docs.first.data()["yellowCards"],
                points: value.docs.first.data()["points"] + team1Points,
                draws: value.docs.first.data()["draws"] +
                    (result == "draw" ? 1 : 0),
                inGoals: value.docs.first.data()["inGoals"] + team2Goals,
                loses: value.docs.first.data()["loses"] +
                    (result == "lose" ? 1 : 0),
                outGoals: value.docs.first.data()["outGoals"] + team1Goals,
                wins:
                    value.docs.first.data()["wins"] + (result == "win" ? 1 : 0),
              ).toMap(),
            )
                .then((value) async {
              await _firestore
                  .collection("teams")
                  .where("name", isEqualTo: team2)
                  .get()
                  .then((value) async {
                await value.docs.first.reference.set(
                  Team(
                    name: value.docs.first.data()["name"],
                    players: value.docs.first.data()["players"],
                    goals: value.docs.first.data()["goals"] - goalsDiff,
                    redCards: value.docs.first.data()["redCards"],
                    yellowCards: value.docs.first.data()["yellowCards"],
                    points: value.docs.first.data()["points"] + team2Points,
                    draws: value.docs.first.data()["draws"] +
                        (result == "draw" ? 1 : 0),
                    inGoals: value.docs.first.data()["inGoals"] + team1Goals,
                    loses: value.docs.first.data()["loses"] +
                        (result == "win" ? 1 : 0),
                    outGoals: value.docs.first.data()["outGoals"] + team2Goals,
                    wins: value.docs.first.data()["wins"] +
                        (result == "lose" ? 1 : 0),
                  ).toMap(),
                );
              });
            });
          });
        });
      });
    } catch (e) {
      debugPrint(e.toString());
      // rethrow;
    }
  }

  //TODO
  Future<void> scheduleMatch(String team1, String team2, int week) async {
    try {
      await _firestore.collection("matches").add(Match(
            id: team1 + team2 + week.toString(),
            team1: team1,
            team2: team2,
            week: week,
            team1Goals: 0,
            team2Goals: 0,
            played: false,
          ).toMap());
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  //TODO
  Future<void> addNewTeam(String teamName, List<String> teamPlayers) async {
    try {
      await _firestore.collection("teams").add(Team(
              draws: 0,
              inGoals: 0,
              loses: 0,
              outGoals: 0,
              wins: 0,
              goals: 0,
              name: teamName,
              players: teamPlayers,
              redCards: 0,
              yellowCards: 0,
              points: 0)
          .toMap());
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> addNewPlayer(String playerName, String teamName) async {
    try {
      await _firestore.collection("players").add(Player(
            goals: 0,
            name: playerName,
            redCards: 0,
            team: teamName,
            yellowCards: 0,
          ).toMap());
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}

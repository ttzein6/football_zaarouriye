import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
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
  Future<void> addMatchResult() async {}
  //TODO
  Future<void> scheduleMatch(String team1, String team2, String week) async {}
  //TODO
  Future<void> addNewTeam(String teamName, List<String> teamPlayers) async {
    try {
      await _firestore.collection("logs").add(Team(
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
}

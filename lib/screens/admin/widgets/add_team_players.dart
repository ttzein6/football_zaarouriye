import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nede_fetyen/constants.dart';
import 'package:nede_fetyen/screens/admin/widgets/new_player_field.dart';
import 'package:nede_fetyen/services/database_services.dart';

class AddNewTeamPlayers extends StatelessWidget {
  String teamName;
  List<PlayerField> playerFields;
  AddNewTeamPlayers(
      {super.key, required this.playerFields, required this.teamName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add New Team Players"),
        actions: [
          IconButton(
              onPressed: () async {
                playerFields.forEach((player) async {
                  log("${player.textEditingController.text}");
                });
                await Database()
                    .addNewTeam(
                        teamName,
                        playerFields
                            .map((e) => e.textEditingController.text)
                            .toList())
                    .then((value) async {
                  await Future.forEach(playerFields, (player) async {
                    await Database().addNewPlayer(
                        player.textEditingController.text, teamName);
                  });
                  playerFields.forEach((player) async {
                    log("${player.textEditingController.text}");
                    player.textEditingController.clear();
                  });
                  Navigator.pop(context);
                });
              },
              icon: Icon(Icons.send, color: Colors.white))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (int i = 0; i < playerFields.length; i++) playerFields[i]
            ],
          ),
        ),
      ),
    );
  }
}

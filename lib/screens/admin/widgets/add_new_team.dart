import 'package:flutter/material.dart';
import 'package:nede_fetyen/constants.dart';
import 'package:nede_fetyen/screens/admin/widgets/add_team_players.dart';
import 'package:nede_fetyen/screens/admin/widgets/new_player_field.dart';

class AddNewTeam extends StatelessWidget {
  AddNewTeam({super.key});
  TextEditingController teamEditingController = TextEditingController();
  TextEditingController playerNumCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add New Team"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: Constants.width * 0.2,
            ),
            TextField(
              controller: teamEditingController,
              decoration: InputDecoration(
                label: Text("Team Name"),
              ),
            ),
            SizedBox(
              height: Constants.width * 0.1,
            ),
            TextField(
              controller: playerNumCont,
              decoration: InputDecoration(
                label: Text("Players Number"),
              ),
            ),
            SizedBox(
              height: Constants.width * 0.1,
            ),
            TextButton(
              onPressed: () {
                List<PlayerField> playerFields = [];
                for (int i = 0; i < int.parse(playerNumCont.text); i++) {
                  playerFields.add(PlayerField(label: "Player #${i + 1}"));
                }
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return AddNewTeamPlayers(
                    teamName: teamEditingController.text,
                    playerFields: playerFields,
                  );
                })));
              },
              child: Text("Add Players"),
            )
          ],
        ),
      ),
    );
  }
}

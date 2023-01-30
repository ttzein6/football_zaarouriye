import 'package:flutter/material.dart';
import 'package:nede_fetyen/models/teams_model.dart';

class TeamStats extends StatelessWidget {
  Team team;
  TeamStats({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("${team.name}"),
          ],
        ),
      ),
    );
  }
}

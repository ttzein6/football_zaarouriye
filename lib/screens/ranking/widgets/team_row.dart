import 'package:flutter/material.dart';
import 'package:nede_fetyen/models/teams_model.dart';

class TeamRow extends StatelessWidget {
  Team team;
  TeamRow({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 0.9,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(color: Colors.black),
                ),
              ),
              child: Text(team.name),
            ),
          ),
          Expanded(
            child: Container(
              height: 50,
              child: Text(team.points.toString()),
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 50,
              child: Text(team.goals.toString()),
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 50,
              child: Text(team.yellowCards.toString()),
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 50,
              child: Text(team.redCards.toString()),
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

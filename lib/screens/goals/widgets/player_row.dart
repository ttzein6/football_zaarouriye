import 'package:flutter/material.dart';
import 'package:nede_fetyen/models/player_model.dart';

class PlayerRow extends StatelessWidget {
  Player player;
  PlayerRow({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 0.9,
      height: 50,
      decoration: BoxDecoration(
        // color: Colors.redAccent,
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              child: Text(player.name),
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
              child: Text(player.team),
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
              child: Text(player.goals.toString()),
            ),
          ),
        ],
      ),
    );
  }
}

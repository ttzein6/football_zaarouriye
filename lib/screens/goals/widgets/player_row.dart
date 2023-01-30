import 'package:flutter/material.dart';
import 'package:nede_fetyen/constants.dart';
import 'package:nede_fetyen/models/player_model.dart';

class PlayerRow extends StatelessWidget {
  Player player;
  int rank;
  PlayerRow({super.key, required this.player, required this.rank});

  @override
  Widget build(BuildContext context) {
    TextStyle rankStyle = TextStyle(
      color: rank % 2 == 0 ? Colors.black : Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: Constants.width * 0.04,
    );
    TextStyle textStyle = TextStyle(
      color: rank % 2 == 0 ? Colors.black : Colors.white,
      fontWeight: FontWeight.normal,
      fontSize: Constants.width * 0.04,
    );
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Center(
      child: Container(
        width: width * 0.9,
        height: Constants.width * 0.06,
        padding: EdgeInsets.only(left: 10),
        margin: EdgeInsets.only(bottom: 10),
        color:
            rank % 2 == 0 ? Colors.white : Colors.deepOrange.withOpacity(0.6),
        // decoration: BoxDecoration(
        //   border: Border(bottom: BorderSide(color: Colors.black)),
        // ),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: Constants.width * 0.05,
                width: Constants.width * 0.1,
                decoration: const BoxDecoration(
                    // border: Border(
                    //   right: BorderSide(color: Colors.black),
                    // ),
                    ),
                child: Text(
                  "$rank",
                  style: rankStyle,
                ),
              ),
              Container(
                height: Constants.width * 0.05,
                width: Constants.width * 0.3,
                decoration: const BoxDecoration(
                    // border: Border(
                    //   right: BorderSide(color: Colors.black),
                    // ),
                    ),
                child: Text(
                  player.name,
                  style: textStyle,
                ),
              ),
              Container(
                height: Constants.width * 0.05,
                width: Constants.width * 0.3,
                child: Text(
                  player.team.toString(),
                  style: textStyle,
                ),
                decoration: const BoxDecoration(
                    // border: Border(
                    //   right: BorderSide(color: Colors.black),
                    // ),
                    ),
              ),
              Container(
                height: Constants.width * 0.05,
                width: Constants.width * 0.1,
                child: Text(
                  player.goals.toString(),
                  style: textStyle,
                ),
                decoration: const BoxDecoration(
                    // border: Border(
                    //   right: BorderSide(color: Colors.black),
                    // ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

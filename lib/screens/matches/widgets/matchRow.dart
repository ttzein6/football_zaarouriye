import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nede_fetyen/constants.dart';
import 'package:nede_fetyen/main.dart';
import 'package:nede_fetyen/models/match_model.dart';

Widget matchRow(Match match) {
  DateTime time = match.time.toDate();
  return Container(
    width: Constants.width * 0.8,
    height: Constants.height * 0.1,
    margin: EdgeInsets.only(bottom: 30),
    decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.all(Radius.circular(50))),
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            match.played == true
                ? "${match.team1.capitalize()}   ${match.team1Goals} - ${match.team2Goals}   ${match.team2.capitalize()}"
                : "${match.team1.capitalize()} VS ${match.team2.capitalize()}",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: Constants.width * 0.05),
          ),
          Text(
            DateFormat.yMEd().add_jms().format(time),
            style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.w700,
                fontSize: Constants.width * 0.035),
          ),
        ],
      ),
    ),
  );
}

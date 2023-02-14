import 'package:flutter/material.dart';
import 'package:nede_fetyen/constants.dart';
import 'package:nede_fetyen/models/match_model.dart';
import 'package:nede_fetyen/screens/matches/widgets/matchRow.dart';

Widget weekRow(context, String week, List<Match> matches) {
  matches.sort((a, b) => a.time.compareTo(b.time));
  return GestureDetector(
    child: Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: Constants.width * 0.67,
      height: Constants.height * 0.06,
      decoration: BoxDecoration(
        color: Colors.deepOrange.withOpacity(0.8),
        borderRadius: const BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: Center(
        child: Text(
          "Week${week.toUpperCase().split("WEEK").join(" ")}",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ),

    // title: Text(week),
    // tileColor: Colors.amberAccent,
    // style: ListTileStyle.list,
    // shape: RoundedRectangleBorder(),
    onTap: () {
      showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) {
            return Container(
              height: Constants.height * 0.8,
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent.withOpacity(0.7),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: Constants.height * 0.1,
                      child: Center(
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              color: Colors.white,
                              icon: Icon(
                                Icons.close,
                                size: 30,
                              ))),
                    ),
                    for (var i = 0; i < matches.length; i++)
                      matchRow(matches[i])
                  ],
                ),
              ),
            );
          });
    },
  );
}

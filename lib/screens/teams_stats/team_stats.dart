import 'package:flutter/material.dart';
import 'package:nede_fetyen/constants.dart';
import 'package:nede_fetyen/main.dart';
import 'package:nede_fetyen/models/teams_model.dart';
import 'package:nede_fetyen/screens/teams_stats/player_list.dart';

class TeamStats extends StatelessWidget {
  Team team;
  TeamStats({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: Constants.width * 0.8,
                  height: Constants.height * 0.2,
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.symmetric(horizontal: Constants.width * 0.02),
                  decoration: const BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Text(
                    team.name.capitalize(),
                    style: TextStyle(
                        fontSize: Constants.width * 0.09, color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: Constants.height * 0.08,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    statsContainer(
                      "Points",
                      team.points.toString(),
                      width: Constants.width * 0.35,
                    ),
                    statsContainer(
                      "Diff Goals",
                      team.goals.toString(),
                      width: Constants.width * 0.35,
                    ),
                  ],
                ),
                SizedBox(
                  height: Constants.height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    statsContainer(
                      "Goals in",
                      team.inGoals.toString(),
                      width: Constants.width * 0.35,
                      color: Colors.purple,
                      textColor: Colors.white,
                    ),
                    statsContainer(
                      "Goals out",
                      team.outGoals.toString(),
                      width: Constants.width * 0.35,
                      color: Colors.purple,
                      textColor: Colors.white,
                    ),
                  ],
                ),
                SizedBox(
                  height: Constants.height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    statsContainer(
                      "Yellow Cards",
                      team.yellowCards.toString(),
                      width: Constants.width * 0.35,
                      color: Colors.brown,
                      textColor: Colors.white,
                    ),
                    statsContainer(
                      "Red Cards",
                      team.redCards.toString(),
                      width: Constants.width * 0.35,
                      color: Colors.brown,
                      textColor: Colors.white,
                    ),
                  ],
                ),
                SizedBox(
                  height: Constants.height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    statsContainer(
                      "Wins",
                      team.wins.toString(),
                      width: Constants.width * 0.25,
                      color: Colors.indigo,
                      textColor: Colors.white,
                    ),
                    statsContainer(
                      "Draws",
                      team.draws.toString(),
                      width: Constants.width * 0.25,
                      color: Colors.indigo,
                      textColor: Colors.white,
                    ),
                    statsContainer(
                      "Loses",
                      team.loses.toString(),
                      width: Constants.width * 0.25,
                      color: Colors.indigo,
                      textColor: Colors.white,
                    ),
                  ],
                ),
                SizedBox(
                  height: Constants.height * 0.04,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepOrange),
                      elevation: MaterialStateProperty.all(25),
                      fixedSize: MaterialStateProperty.all(Size(
                          Constants.width * 0.45, Constants.height * 0.07))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PlayerList(team: team)));
                  },
                  child: Container(
                      // decoration: BoxDecoration(boxShadow: [

                      // ], color: Colors.deepOrange),
                      alignment: Alignment.center,
                      width: Constants.width * 0.25,
                      height: Constants.height * 0.06,
                      child: Text(
                        "View Players",
                        style: TextStyle(fontSize: Constants.width * 0.04),
                      )),
                ),
                SizedBox(
                  height: Constants.height * 0.06,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget statsContainer(String title, String value,
      {Color color = Colors.amber,
      double? width,
      Color textColor = Colors.black}) {
    TextStyle textStyle = TextStyle(
      fontSize: Constants.width * 0.04,
      color: textColor,
    );
    return Container(
      width: width ?? Constants.width * 0.25,
      height: Constants.width * 0.13,
      // padding: EdgeInsets.symmetric(horizontal: Constants.height * 0.0),
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: Constants.height * 0.01,
            ),
            Text(
              title,
              style: textStyle,
            ),
            Text(
              value,
              style: textStyle,
            ),
            SizedBox(
              height: Constants.height * 0.01,
            ),
          ],
        ),
      ),
    );
  }
}

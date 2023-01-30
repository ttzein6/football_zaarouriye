import 'package:flutter/material.dart';
import 'package:nede_fetyen/constants.dart';
import 'package:nede_fetyen/models/teams_model.dart';

class TeamRow extends StatelessWidget {
  Team team;
  int rank;
  // ScrollController scrollController;
  TeamRow({
    super.key,
    required this.team,
    required this.rank,
    // required this.scrollController
  });

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
    Color bgColor =
        rank % 2 == 0 ? Colors.white : Colors.deepOrange.withOpacity(0.6);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return
        // Container(
        //   width: width * 0.9,
        //   height: Constants.width * 0.06,
        //   padding: EdgeInsets.only(left: 10),
        //   margin: EdgeInsets.only(bottom: 10),
        //   color: rank % 2 == 0 ? Colors.white : Colors.deepOrange.withOpacity(0.6),
        //   // decoration: BoxDecoration(
        //   //   border: Border(bottom: BorderSide(color: Colors.black)),
        //   // ),
        //   child:
        Row(
      // scrollDirection: Axis.horizontal,
      // physics: ScrollPhysics(),
      // controller: scrollController,
      children: [
        Container(
          height: Constants.width * 0.05,
          width: Constants.width * 0.15,
          decoration: BoxDecoration(
            color: bgColor,
            // border: Border(
            //   right: BorderSide(color: Colors.black),
            // ),
          ),
          child: Text(
            "$rank",
            style: rankStyle,
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          height: Constants.width * 0.05,
          width: Constants.width * 0.33,
          decoration: BoxDecoration(color: bgColor
              // border: Border(
              //   right: BorderSide(color: Colors.black),
              // ),
              ),
          child: Text(
            team.name,
            style: textStyle,
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          height: Constants.width * 0.05,
          width: Constants.width * 0.15,
          child: Text(
            team.points.toString(),
            style: textStyle,
            textAlign: TextAlign.center,
          ),
          decoration: BoxDecoration(color: bgColor
              // border: Border(
              //   right: BorderSide(color: Colors.black),
              // ),
              ),
        ),
        Container(
          height: Constants.width * 0.05,
          width: Constants.width * 0.2,
          child: Text(
            team.goals.toString(),
            style: textStyle,
            textAlign: TextAlign.center,
          ),
          decoration: BoxDecoration(color: bgColor
              // border: Border(
              //   right: BorderSide(color: Colors.black),
              // ),
              ),
        ),
        Container(
          height: Constants.width * 0.05,
          width: Constants.width * 0.15,
          child: Text(
            team.yellowCards.toString(),
            style: textStyle,
            textAlign: TextAlign.center,
          ),
          decoration: BoxDecoration(color: bgColor
              // border: Border(
              //   right: BorderSide(color: Colors.black),
              // ),
              ),
        ),
        Container(
          height: Constants.width * 0.05,
          width: Constants.width * 0.15,
          child: Text(
            team.redCards.toString(),
            style: textStyle,
            textAlign: TextAlign.center,
          ),
          decoration: BoxDecoration(color: bgColor
              // border: Border(
              //   right: BorderSide(color: Colors.black),
              // ),
              ),
        ),
      ],
      // ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nede_fetyen/constants.dart';
import 'package:nede_fetyen/models/player_model.dart';
import 'package:nede_fetyen/screens/ranking/bloc/ranking_bloc.dart';
import 'package:nede_fetyen/screens/ranking/widgets/team_row.dart';

class RankingScreen extends StatefulWidget {
  RankingScreen({
    super.key,
  });

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  @override
  void initState() {
    context.read<RankingBloc>().add(GetTeamsData());
    super.initState();
  }

  TextStyle firstRowStyle = TextStyle(
    color: Colors.black54,
    fontSize: Constants.width * 0.035,
  );
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(
      //   // centerTitle: true,
      //   // title: Text("Ranking"),
      //   // leading: IconButton(
      //   //   onPressed: () {
      //   //     Navigator.pop(context);
      //   //   },
      //   //   icon: Icon(
      //   //     Icons.arrow_back_ios,
      //   //     color: Colors.black,
      //   //   ),
      //   // ),
      //   elevation: 0,
      //   backgroundColor: Colors.white,
      // ),
      body: SafeArea(
        child: BlocBuilder<RankingBloc, RankingState>(
          builder: (context, state) {
            if (state is RankingLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is RankingLoaded) {
              List<Widget> rows = [
                Container(
                  // width: width * 0.9,
                  height: Constants.width * 0.08,
                ),
                Container(
                  height: Constants.width * 0.06,
                  // width: width * 0.9,
                  // decoration: BoxDecoration(
                  //     border: Border(bottom: BorderSide(color: Colors.black))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: Constants.width * 0.06,
                        child: Row(
                          // scrollDirection: Axis.horizontal,

                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: Constants.width * 0.04,
                              width: Constants.width * 0.15,
                              child: Text(
                                "Rank",
                                textAlign: TextAlign.center,
                                style: firstRowStyle,
                              ),
                              decoration: const BoxDecoration(),
                            ),
                            Container(
                              height: Constants.width * 0.04,
                              width: Constants.width * 0.33,
                              child: Text(
                                "Team",
                                style: firstRowStyle,
                                textAlign: TextAlign.center,
                              ),
                              decoration: const BoxDecoration(),
                            ),
                            Container(
                              height: Constants.width * 0.04,
                              width: Constants.width * 0.15,
                              child: Text(
                                "Points",
                                style: firstRowStyle,
                                textAlign: TextAlign.center,
                              ),
                              decoration: const BoxDecoration(),
                            ),
                            Container(
                              height: Constants.width * 0.04,
                              width: Constants.width * 0.2,
                              child: Text(
                                "GD",
                                style: firstRowStyle,
                                textAlign: TextAlign.center,
                              ),
                              decoration: const BoxDecoration(),
                            ),
                            Container(
                              height: Constants.width * 0.04,
                              width: Constants.width * 0.15,
                              child: Text(
                                "YC",
                                style: firstRowStyle,
                                textAlign: TextAlign.center,
                              ),
                              decoration: const BoxDecoration(),
                            ),
                            Container(
                              height: Constants.width * 0.04,
                              width: Constants.width * 0.15,
                              child: Text(
                                "RC",
                                textAlign: TextAlign.center,
                                style: firstRowStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ];
              for (var i = 0; i < state.teamsData.length; i++) {
                var team = state.teamsData[i];
                rows.add(TeamRow(
                  team: team,
                  rank: i + 1,
                ));
              }

              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      height: width * 0.1,
                      // height: Constants.width * 0.02,
                    ),
                    Container(
                      width: Constants.width * 0.7,
                      height: Constants.width * 0.4,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.deepOrange.withOpacity(0.8),
                          borderRadius: BorderRadius.all(
                              Radius.circular(Constants.width * 0.05))),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "#1",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: Constants.width * 0.13,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "${state.teamsData[0].name}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: Constants.width * 0.05,
                                  ),
                                ),
                                SizedBox(
                                  height: Constants.width * 0.01,
                                ),
                                Text(
                                  "${state.teamsData[0].points} Points",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: Constants.width * 0.06,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Image.asset(
                              "assets/images/cup.png",
                              width: Constants.width * 0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: ScrollPhysics(),
                      child:
                          //  Container(
                          //   width: Constants.width,
                          //   padding: EdgeInsets.all(30),
                          // child:
                          Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // shrinkWrap: true,
                        // scrollDirection: Axis.vertical,
                        // physics: ScrollPhysics(),
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: rows,
                      ),
                      // ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              );
            } else {
              context.read<RankingBloc>().add(GetTeamsData());
              return Container(
                child: Text("No Data"),
              );
            }
          },
        ),
      ),
    );
  }
}

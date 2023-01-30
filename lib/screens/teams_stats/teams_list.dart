import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nede_fetyen/constants.dart';
import 'package:nede_fetyen/models/teams_model.dart';
import 'package:nede_fetyen/screens/matches/bloc/matches_bloc.dart';
import 'package:nede_fetyen/screens/ranking/bloc/ranking_bloc.dart';
import 'package:nede_fetyen/screens/teams_stats/team_stats.dart';

class TeamsListScreen extends StatefulWidget {
  TeamsListScreen({super.key});

  @override
  State<TeamsListScreen> createState() => _TeamsListScreenState();
}

class _TeamsListScreenState extends State<TeamsListScreen> {
  TextEditingController searchController = TextEditingController();

  List<Team> teams = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RankingBloc, RankingState>(
      builder: (context, state) {
        if (state is RankingLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is RankingLoaded) {
          if (teams.isEmpty) {
            teams = state.teamsData;
          }
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: Constants.height * 0.06,
                    child: Text(
                      "Teams",
                      style: TextStyle(
                          fontSize: Constants.width * 0.1,
                          fontWeight: FontWeight.w600,
                          color: Colors.deepOrange,
                          shadows: [
                            Shadow(
                                color: Colors.grey.shade200, //New
                                blurRadius: 25.0,
                                offset: Offset(-10, 10))
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: Constants.height * 0.07,
                    margin:
                        EdgeInsets.symmetric(horizontal: Constants.width * 0.1),
                    padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.red)),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "Search for teams ...",
                        // border: OutlineInputBorder(),
                        labelText: "Search",
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        List<Team> newTeams = [];
                        for (var element in state.teamsData) {
                          if (element.name.contains(value)) {
                            newTeams.add(element);
                          }
                        }
                        setState(() {
                          teams = newTeams;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    // height: Constants.height * 0.5,
                    // color: Colors.amber,
                    child: ListView.builder(
                      shrinkWrap: false,
                      physics: const ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: teams.length,
                      itemBuilder: (context, index) {
                        return teamROW(teams[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget teamROW(Team team) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => TeamStats(team: team)));
      },
      child: Center(
        child: Container(
          width: Constants.width * 0.7,
          margin: EdgeInsets.only(bottom: 30),
          padding: EdgeInsets.all(Constants.width * 0.05),
          decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: Center(
              child: Text(
            team.name,
            style: TextStyle(
                color: Colors.white, fontSize: Constants.width * 0.06),
          )),
        ),
      ),
    );
  }
}

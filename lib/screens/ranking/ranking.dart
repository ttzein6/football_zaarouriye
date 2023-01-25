import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nede_fetyen/models/player_model.dart';
import 'package:nede_fetyen/screens/ranking/bloc/ranking_bloc.dart';
import 'package:nede_fetyen/screens/ranking/widgets/team_row.dart';

class Shuffler extends StatefulWidget {
  Shuffler({
    super.key,
  });

  @override
  State<Shuffler> createState() => _ShufflerState();
}

class _ShufflerState extends State<Shuffler> {
  @override
  void initState() {
    context.read<RankingBloc>().add(GetTeamsData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Ranking"),
      ),
      body: BlocBuilder<RankingBloc, RankingState>(
        builder: (context, state) {
          if (state is RankingLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is RankingLoaded) {
            List<Widget> rows = [
              Container(
                width: width * 0.9,
                height: 50,
              ),
              Container(
                height: 50,
                width: width * 0.9,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        child: const Text("Team"),
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
                        child: const Text("Points"),
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
                        child: const Text("Goals Diff"),
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
                        child: const Text("YC"),
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
                        child: const Text("RC"),
                      ),
                    ),
                  ],
                ),
              )
            ];
            for (var team in state.teamsData) {
              rows.add(TeamRow(team: team));
            }

            return SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: rows,
                ),
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
    );
  }
}

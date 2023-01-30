import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nede_fetyen/constants.dart';
import 'package:nede_fetyen/models/player_model.dart';
import 'package:nede_fetyen/screens/goals/bloc/goals_bloc.dart';
import 'package:nede_fetyen/screens/goals/widgets/player_row.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  @override
  void initState() {
    context.read<GoalsBloc>().add(GetGoalsData());
    super.initState();
  }

  TextStyle firstRowStyle = TextStyle(
    color: Colors.black54,
    fontSize: Constants.width * 0.03,
  );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<GoalsBloc, GoalsState>(
          builder: (context, state) {
            if (state is GoalsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GoalsLoaded) {
              List<Widget> rows = [
                Container(
                  width: width * 0.9,
                  height: 30,
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
                              "${state.playersData[0].name}",
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
                              "${state.playersData[0].goals} Goals",
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
                Container(
                  width: width * 0.9,
                  height: 30,
                ),
                Container(
                  width: width * 0.9,
                  height: Constants.width * 0.06,
                  decoration: BoxDecoration(
                      // color: Colors.redAccent,
                      // border: Border.all(color: Colors.black),
                      ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: Constants.width * 0.05,
                        width: Constants.width * 0.1,
                        child: Text(
                          "Rank",
                          style: firstRowStyle,
                        ),
                        decoration: const BoxDecoration(),
                      ),
                      Container(
                        height: Constants.width * 0.05,
                        width: Constants.width * 0.3,
                        child: Text(
                          "Player",
                          style: firstRowStyle,
                        ),
                        decoration: const BoxDecoration(),
                      ),
                      Container(
                        height: Constants.width * 0.05,
                        width: Constants.width * 0.3,
                        child: Text(
                          "Team",
                          style: firstRowStyle,
                        ),
                        decoration: const BoxDecoration(),
                      ),
                      Container(
                        height: Constants.width * 0.05,
                        width: Constants.width * 0.1,
                        child: Text(
                          "Goals",
                          style: firstRowStyle,
                        ),
                        decoration: const BoxDecoration(),
                      ),
                    ],
                  ),
                ),
              ];
              List<Player> players = state.playersData;

              for (var i = 0; i < players.length; i++) {
                var player = players[i];
                rows.add(PlayerRow(
                  player: player,
                  rank: i + 1,
                ));
              }
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: rows,
                ),
              );
            } else {
              context.read<GoalsBloc>().add(GetGoalsData());
              return Container();
            }
          },
        ),
      ),
    );
  }
}

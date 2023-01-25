import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Goals"),
      ),
      body: BlocBuilder<GoalsBloc, GoalsState>(
        builder: (context, state) {
          if (state is GoalsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GoalsLoaded) {
            List<Widget> rows = [
              Container(
                width: width * 0.9,
                height: 50,
              ),
              Container(
                width: width * 0.9,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    border: Border.all(color: Colors.black)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        child: const Text("Player"),
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
                        child: const Text("Goals"),
                      ),
                    ),
                  ],
                ),
              ),
            ];
            List<Player> players = state.playersData;

            players.forEach(((player) {
              rows.add(PlayerRow(player: player));
            }));

            return SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: rows,
                ),
              ),
            );
          } else {
            context.read<GoalsBloc>().add(GetGoalsData());
            return Container();
          }
        },
      ),
    );
  }
}

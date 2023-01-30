import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nede_fetyen/screens/matches/bloc/matches_bloc.dart';
import 'package:nede_fetyen/screens/matches/widgets/weekRow.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({super.key});

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  @override
  void initState() {
    context.read<MatchesBloc>().add(GetAllMatches());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: BlocBuilder<MatchesBloc, MatchesState>(
            builder: (context, state) {
              if (state is MatchesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is MatchesLoaded) {
                return Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (var i = 0; i < state.weeks.length; i++)
                          weekRow(context, state.weeks[i],
                              state.weekMatchesMap[state.weeks[i]]!)
                      ],
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}

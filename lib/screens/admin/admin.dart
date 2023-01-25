import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nede_fetyen/constants.dart';
import 'package:nede_fetyen/screens/admin/bloc/admin_bloc.dart';
import 'package:nede_fetyen/screens/admin/widgets/add_new_team.dart';
import 'package:nede_fetyen/screens/admin/widgets/add_player_goals.dart';
import 'package:nede_fetyen/screens/admin/widgets/add_player_rc.dart';
import 'package:nede_fetyen/screens/admin/widgets/add_player_yc.dart';
import 'package:nede_fetyen/screens/admin/widgets/option.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminBloc, AdminState>(
      builder: (context, state) {
        if (state is AdminLoaded) {
          List<Option> options = [
            Option(
              title: "Add Player Goals",
              destination: AddPlayerGoals(
                players: state.players,
              ),
            ), //add player goals
            Option(
              title: "Add Player Yellow Card",
              destination: AddPlayerYc(players: state.players),
            ),
            Option(
              title: "Add Player Red Card",
              destination: AddPlayerRc(
                players: state.players,
              ),
            ),
            Option(
              title: "Add Match Result",
              destination: Container(),
            ),
            Option(
              title: "Schedule Match",
              destination: Container(),
            ),
            Option(
              title: "Add New Team",
              destination: AddNewTeam(),
            ), // schedule match
          ];
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Admin"),
            ),
            body: Center(
              child: GridView.count(
                // semanticChildCount:5,
                mainAxisSpacing: 20,
                crossAxisSpacing: Constants.width * 0.1,
                shrinkWrap: true,
                padding: EdgeInsets.all(Constants.width * 0.05),
                // gridDelegate:
                //     SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                crossAxisCount: 2,
                children: options,
              ),
            ),
          );
        } else if (state is AdminLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          context.read<AdminBloc>().add(GetPlayersData());
          return Container();
        }
      },
    );
  }
}

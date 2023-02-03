import 'package:flutter/material.dart';
import 'package:nede_fetyen/constants.dart';
import 'package:nede_fetyen/main.dart';
import 'package:nede_fetyen/models/teams_model.dart';

class PlayerList extends StatelessWidget {
  final Team team;
  const PlayerList({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
          title: Text("${team.name.capitalize()} Players"),
          centerTitle: true,
          elevation: 0,
          // backgroundColor: Colors.transparent,
        ),
        body: ListView.separated(
          padding: EdgeInsets.symmetric(
              horizontal: Constants.width * .05,
              vertical: Constants.height * .03),
          itemCount: team.players.length,
          separatorBuilder: (context, index) {
            // <-- SEE HERE
            return const Divider(
              thickness: 2,
            );
          },
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                child: Text(
                  (index + 1).toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(team.players[index]),
              // tileColor: Colors.amber,
              // style: ,
            );
          },
          // children: ListTile.divideTiles(context: context,

          //  tiles: [
          //   for (var i = 0; i < team.players.length; i++)
          //     ListTile(
          //       leading: CircleAvatar(
          //         backgroundColor: const Color(0xff764abc),
          //         child: Text(
          //           i.toString(),
          //           style: TextStyle(color: Colors.white),
          //         ),
          //       ),
          //       title: Text(
          //         (team.players[i] as String).capitalize(),
          //         style: TextStyle(fontSize: Constants.width * 0.05),
          //       ),
          //       // tileColor: Colors.amber,
          //       // style: ,
          //     )
          // ]).toList(),
        ),
      ),
    );
  }
}

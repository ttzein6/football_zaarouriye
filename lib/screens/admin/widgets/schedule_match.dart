import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nede_fetyen/constants.dart';
import 'package:nede_fetyen/models/player_model.dart';
import 'package:nede_fetyen/models/teams_model.dart';
import 'package:nede_fetyen/services/database_services.dart';

class ScheduleMatch extends StatefulWidget {
  List<Team> teams;
  ScheduleMatch({super.key, required this.teams});

  @override
  State<ScheduleMatch> createState() => _ScheduleMatchState();
}

class _ScheduleMatchState extends State<ScheduleMatch> {
  TextEditingController team1 = TextEditingController();
  TextEditingController team2 = TextEditingController();
  TextEditingController week = TextEditingController();

  bool _isLoading = false;
  List<Team>? teams;
  @override
  void initState() {
    teams = widget.teams;
    super.initState();
  }

  List<Team> searchPlayers(String text) {
    List<Team> newTeams = [];
    widget.teams.forEach((element) {
      if (element.name.toLowerCase().contains(text.toLowerCase())) {
        newTeams.add(element);
      }
    });
    return newTeams;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Schedule Match"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              readOnly: true,
              controller: team1,
              decoration: const InputDecoration(
                label: Text("Team 1 Name"),
              ),
              onTap: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Constants.width * 0.1),
                            topRight: Radius.circular(Constants.width * 0.1))),
                    context: context,
                    builder: (context) {
                      TextEditingController textEditingController =
                          TextEditingController();
                      List<Team> playersToShow = teams!;
                      return StatefulBuilder(
                          builder: (context, setBuilderState) {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            child: Column(
                              children: [
                                TextField(
                                  controller: textEditingController,
                                  decoration: const InputDecoration(
                                      hintText: "Search ..."),
                                  onChanged: (value) {
                                    setBuilderState(() {
                                      playersToShow = searchPlayers(value);
                                    });
                                  },
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: playersToShow.length,
                                    itemBuilder: ((context, index) {
                                      String name = playersToShow[index].name;
                                      return ListTile(
                                        onTap: () {
                                          team1.text = name;
                                          Navigator.pop(context);
                                        },
                                        title: Text(name),
                                      );
                                    })),
                              ],
                            ),
                          ),
                        );
                      });
                    });
              },
            ),
            TextField(
              readOnly: true,
              controller: team2,
              decoration: const InputDecoration(
                label: Text("Team 2 Name"),
              ),
              onTap: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Constants.width * 0.1),
                            topRight: Radius.circular(Constants.width * 0.1))),
                    context: context,
                    builder: (context) {
                      TextEditingController textEditingController =
                          TextEditingController();
                      List<Team> playersToShow = teams!;
                      return StatefulBuilder(
                          builder: (context, setBuilderState) {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            child: Column(
                              children: [
                                TextField(
                                  controller: textEditingController,
                                  decoration: const InputDecoration(
                                      hintText: "Search ..."),
                                  onChanged: (value) {
                                    setBuilderState(() {
                                      playersToShow = searchPlayers(value);
                                    });
                                  },
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: playersToShow.length,
                                    itemBuilder: ((context, index) {
                                      String name = playersToShow[index].name;
                                      return ListTile(
                                        onTap: () {
                                          team2.text = name;
                                          Navigator.pop(context);
                                        },
                                        title: Text(name),
                                      );
                                    })),
                              ],
                            ),
                          ),
                        );
                      });
                    });
              },
            ),
            TextField(
              controller: week,
              decoration: const InputDecoration(
                label: Text("Week Number"),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () async {
                if (_isLoading == false) {
                  setState(() {
                    _isLoading = true;
                  });
                  if (team1.text.isNotEmpty &&
                      team2.text.isNotEmpty &&
                      week.text.isNotEmpty) {
                    await Database()
                        .scheduleMatch(
                            team1.text, team2.text, int.parse(week.text))
                        .then((value) {
                      team1.clear();
                      team2.clear();
                      week.clear();
                    });
                  }
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
              child: _isLoading ? CircularProgressIndicator() : Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}

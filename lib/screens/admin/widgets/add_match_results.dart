import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nede_fetyen/constants.dart';
import 'package:nede_fetyen/models/match_model.dart';
import 'package:nede_fetyen/models/player_model.dart';
import 'package:nede_fetyen/models/teams_model.dart';
import 'package:nede_fetyen/services/database_services.dart';

class AddMatchResult extends StatefulWidget {
  List<Match> matches;
  AddMatchResult({super.key, required this.matches});

  @override
  State<AddMatchResult> createState() => _AddMatchResultState();
}

class _AddMatchResultState extends State<AddMatchResult> {
  TextEditingController match = TextEditingController();
  TextEditingController matchId = TextEditingController();

  TextEditingController team1Goals = TextEditingController();
  TextEditingController team2Goals = TextEditingController();

  bool _isLoading = false;
  List<Match>? matches;
  @override
  void initState() {
    matches = widget.matches;
    super.initState();
  }

  List<Match> searchMatches(String text) {
    List<Match> newMatches = [];
    for (var element in widget.matches) {
      if (element.id.toLowerCase().contains(text.toLowerCase())) {
        newMatches.add(element);
      }
    }
    return newMatches;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add Match Result"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              readOnly: true,
              controller: match,
              decoration: const InputDecoration(
                label: Text("Match"),
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
                      List<Match> playersToShow = matches!;
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
                                      playersToShow = searchMatches(value);
                                    });
                                  },
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: playersToShow.length,
                                    itemBuilder: ((context, index) {
                                      String name =
                                          "${playersToShow[index].team1} VS ${playersToShow[index].team2}";
                                      return ListTile(
                                        onTap: () {
                                          match.text = name;
                                          matchId.text =
                                              playersToShow[index].id;
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
              readOnly: false,
              controller: team1Goals,
              decoration: const InputDecoration(
                label: Text("Team 1 Goals"),
              ),
            ),
            TextField(
              controller: team2Goals,
              decoration: const InputDecoration(
                label: Text("Team 2 Goals"),
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
                  if (match.text.isNotEmpty &&
                      team1Goals.text.isNotEmpty &&
                      team2Goals.text.isNotEmpty) {
                    var selectedMatch = matches!
                        .where((element) => element.id == matchId.text)
                        .first;
                    await Database()
                        .addMatchResult(
                            matchId.text,
                            selectedMatch.team1,
                            selectedMatch.team2,
                            int.parse(team1Goals.text),
                            int.parse(team2Goals.text))
                        .then((value) {
                      match.clear();
                      matchId.clear();
                      team1Goals.clear();
                      team2Goals.clear();
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

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nede_fetyen/constants.dart';
import 'package:nede_fetyen/models/player_model.dart';
import 'package:nede_fetyen/services/database_services.dart';

class AddPlayerYc extends StatefulWidget {
  List<Player> players;
  AddPlayerYc({super.key, required this.players});

  @override
  State<AddPlayerYc> createState() => _AddPlayerYcState();
}

class _AddPlayerYcState extends State<AddPlayerYc> {
  TextEditingController nameEditingController = TextEditingController();
  bool _isLoading = false;
  List<Player>? players;
  @override
  void initState() {
    players = widget.players;
    super.initState();
  }

  List<Player> searchPlayers(String text) {
    List<Player> newPlayers = [];
    widget.players.forEach((element) {
      if (element.name.toLowerCase().contains(text.toLowerCase())) {
        newPlayers.add(element);
      }
    });
    return newPlayers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add Player Yellow Card"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              readOnly: true,
              controller: nameEditingController,
              decoration: const InputDecoration(
                label: Text("Player Name"),
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
                      List<Player> playersToShow = players!;
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
                                          nameEditingController.text = name;
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
            const SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () async {
                if (_isLoading == false) {
                  log("Name : ${nameEditingController.text}");

                  setState(() {
                    _isLoading = true;
                  });
                  if (nameEditingController.text.isNotEmpty) {
                    await Database()
                        .addPlayerYellowCards(
                      nameEditingController.text,
                      widget.players
                          .where((element) =>
                              element.name == nameEditingController.text)
                          .first
                          .team,
                    )
                        .then((value) {
                      nameEditingController.clear();
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

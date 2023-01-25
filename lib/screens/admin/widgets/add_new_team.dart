import 'package:flutter/material.dart';

class AddNewTeam extends StatelessWidget {
  const AddNewTeam({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add New Team"),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              label: Text("Team Name"),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              label: Text("Players Number"),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text("Add Players"),
          )
        ],
      ),
    );
  }
}

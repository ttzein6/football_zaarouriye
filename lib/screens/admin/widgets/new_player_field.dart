import 'package:flutter/material.dart';

class PlayerField extends StatelessWidget {
  PlayerField({super.key, required this.label});
  String label;
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        label: Text(label),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nede_fetyen/constants.dart';

class Option extends StatelessWidget {
  String title;
  Widget destination;

  Option({super.key, required this.title, required this.destination});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => destination));
      },
      child: Container(
        width: Constants.width * 0.33,
        height: Constants.width * 0.33,
        decoration: BoxDecoration(
            color: Colors.amber,
            // border: Border.all(),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 3,
                  spreadRadius: 3,
                  offset: Offset(10, 10))
            ],
            borderRadius:
                BorderRadius.all(Radius.circular(Constants.width * 0.05))),
        child: Center(
            child: Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        )),
      ),
    );
  }
}

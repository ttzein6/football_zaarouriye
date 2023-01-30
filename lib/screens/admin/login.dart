import 'package:flutter/material.dart';
import 'package:nede_fetyen/screens/admin/admin.dart';

class AdminLogin extends StatelessWidget {
  AdminLogin({super.key});
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin Login")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
            child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
              controller: textEditingController,
            ),
            IconButton(
                onPressed: () {
                  if (textEditingController.text == "boudiTamer") {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AdminScreen()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Wrong Password !"),
                      ),
                    );
                  }
                  textEditingController.clear();
                },
                icon: Icon(Icons.login))
          ],
        )),
      ),
    );
  }
}

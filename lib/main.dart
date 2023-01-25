import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nede_fetyen/constants.dart';
import 'package:nede_fetyen/firebase_options.dart';
import 'package:nede_fetyen/screens/admin/admin.dart';
import 'package:nede_fetyen/screens/admin/bloc/admin_bloc.dart';
import 'package:nede_fetyen/screens/goals/bloc/goals_bloc.dart';
import 'package:nede_fetyen/screens/goals/goals.dart';
import 'package:nede_fetyen/screens/ranking/bloc/ranking_bloc.dart';
import 'package:nede_fetyen/screens/ranking/ranking.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GoalsBloc(),
        ),
        BlocProvider(
          create: (context) => RankingBloc(),
        ),
        BlocProvider(
          create: (context) => AdminBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: false,
          primarySwatch: Colors.amber,
        ),
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Constants.width = MediaQuery.of(context).size.width;
    Constants.height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Dashboard"),
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  optionCard(
                      optionText: "Ranking",
                      context: context,
                      destination: Shuffler()),
                  optionCard(optionText: "Matches", context: context),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  optionCard(
                      optionText: "Goals",
                      context: context,
                      destination: GoalsScreen()),
                  optionCard(
                      optionText: "Admin Only",
                      context: context,
                      destination: Material(child: AdminScreen())),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget optionCard(
    {required String optionText,
    required BuildContext context,
    Widget? destination}) {
  return GestureDetector(
    onTap: () async {
      if (destination != null) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: ((context) => destination)));
      }
    },
    child: Container(
      width: Constants.width * 0.4,
      height: Constants.width * 0.4,
      decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                blurRadius: 3,
                offset: Offset.fromDirection(1))
          ]),
      child: Center(
          child: Text(
        optionText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      )),
    ),
  );
}

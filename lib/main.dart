import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nede_fetyen/constants.dart';
import 'package:nede_fetyen/firebase_options.dart';
import 'package:nede_fetyen/screens/admin/admin.dart';
import 'package:nede_fetyen/screens/admin/bloc/admin_bloc.dart';
import 'package:nede_fetyen/screens/admin/login.dart';
import 'package:nede_fetyen/screens/goals/bloc/goals_bloc.dart';
import 'package:nede_fetyen/screens/goals/goals.dart';
import 'package:nede_fetyen/screens/matches/bloc/matches_bloc.dart';
import 'package:nede_fetyen/screens/matches/matches.dart';
import 'package:nede_fetyen/screens/ranking/bloc/ranking_bloc.dart';
import 'package:nede_fetyen/screens/ranking/ranking.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:nede_fetyen/screens/teams_stats/teams_list.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  usePathUrlStrategy();
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
        BlocProvider(
          create: (context) => MatchesBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Fetyan Football',
        theme: ThemeData(
          useMaterial3: false,
          primarySwatch: Colors.deepOrange,
        ),
        builder: (context, child) {
          return ResponsiveWrapper.builder(
            BouncingScrollWrapper.builder(context, child!),
            minWidth: 300,
            debugLog: true,
            defaultScale: true,
            breakpoints: [
              const ResponsiveBreakpoint.autoScaleDown(450, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(800, name: TABLET),
              const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ],
            background: Container(color: Colors.deepOrange),
          );
        },
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

  int index = 0;
  List<Widget> pages = [
    RankingScreen(),
    // GoalsScreen(),
    TeamsListScreen(),
    MatchesScreen(),
    AdminLogin(),
  ];
  @override
  Widget build(BuildContext context) {
    Constants.width = MediaQuery.of(context).size.width > 700
        ? 700
        : MediaQuery.of(context).size.width;
    Constants.height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: SafeArea(
        maintainBottomViewPadding: true,
        child: Container(
          width: Constants.width,
          height: Constants.height * 0.1,
          decoration: BoxDecoration(
              color: Colors.deepOrange.withOpacity(0.5),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade400, //New
                    blurRadius: 25.0,
                    offset: Offset(0, -10))
              ]),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      index = 0;
                    });
                  },
                  // child: SvgPicture.asset(
                  //   "assets/images/ranking.svg",
                  //   width: Constants.width * 0.175,
                  //   color: index == 0 ? Colors.grey : Colors.white,
                  //   // color: Colors.white,
                  // ),
                  child: Icon(
                    Icons.score_sharp,
                    color: index == 0 ? Colors.green : Colors.white,
                    size: 30,
                  )),
              IconButton(
                  onPressed: () {
                    setState(() {
                      index = 1;
                    });
                  },
                  icon: Icon(
                    Icons.people_alt,
                    color: index == 1 ? Colors.green : Colors.white,
                    size: 30,
                  )),
              IconButton(
                  onPressed: () {
                    setState(() {
                      index = 2;
                    });
                  },
                  icon: Icon(
                    Icons.schedule,
                    color: index == 2 ? Colors.green : Colors.white,
                    size: 30,
                  )),
              // IconButton(
              //     onPressed: () {
              //       setState(() {
              //         index = 3;
              //       });
              //     },
              //     icon: Icon(
              //       Icons.lock,
              //       color: index == 3 ? Colors.green : Colors.white,
              //       size: 30,
              //     )),
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
          color: Colors.deepOrange.withOpacity(0.8),
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

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

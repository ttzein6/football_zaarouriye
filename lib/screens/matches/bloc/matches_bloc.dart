import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nede_fetyen/models/match_model.dart';
import 'package:nede_fetyen/services/database_services.dart';

part 'matches_event.dart';
part 'matches_state.dart';

class MatchesBloc extends Bloc<MatchesEvent, MatchesState> {
  Map<String, List<Match>> weekMatchesMapDefault = {
    "week1": [],
    "week2": [],
    "week3": [],
    "week4": [],
    "week5": [],
    "week6": [],
    "week7": [],
    "week8": [],
    "week9": [],
    "week10": [],
    "week11": [],
    "week12": [],
  };
  Map<String, List<Match>> weekMatchesMap = {
    "week1": [],
    "week2": [],
    "week3": [],
    "week4": [],
    "week5": [],
    "week6": [],
    "week7": [],
    "week8": [],
    "week9": [],
    "week10": [],
    "week11": [],
    "week12": [],
  };
  List<String> weeks = [
    "week1",
    "week2",
    "week3",
    "week4",
    "week5",
    "week6",
    "week7",
    "week8",
    "week9",
    "week10",
    "week11",
    "week12"
  ];
  MatchesBloc() : super(MatchesInitial()) {
    on<GetAllMatches>((event, emit) async {
      weekMatchesMap = {
        "week1": [],
        "week2": [],
        "week3": [],
        "week4": [],
        "week5": [],
        "week6": [],
        "week7": [],
        "week8": [],
        "week9": [],
        "week10": [],
        "week11": [],
        "week12": [],
      };
      emit(MatchesLoading());

      await Database().getMatchesData().then((value) {
        for (var element in value!) {
          weekMatchesMap["week${element.week}"]!.add(element);
        }
        emit(MatchesLoaded(
            matchesData: value, weekMatchesMap: weekMatchesMap, weeks: weeks));
      });
    });
  }
}

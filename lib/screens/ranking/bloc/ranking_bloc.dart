import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nede_fetyen/models/teams_model.dart';
import 'package:nede_fetyen/services/database_services.dart';

part 'ranking_event.dart';
part 'ranking_state.dart';

class RankingBloc extends Bloc<RankingEvent, RankingState> {
  RankingBloc() : super(RankingInitial()) {
    List<Team> teams = [];
    on<GetTeamsData>((event, emit) async {
      emit(RankingLoading());
      await Database().getTeamsData().then((value) {
        teams = value ?? [];
        teams.sort((a, b) {
          int points = b.points.compareTo(a.points);
          if (points != 0) {
            return points;
          } else {
            int goals = b.goals.compareTo(a.goals);
            if (goals != 0) {
              return goals;
            } else {
              int yellowCards = a.yellowCards.compareTo(b.yellowCards);
              if (yellowCards != 0) {
                return yellowCards;
              } else {
                return a.redCards.compareTo(b.redCards);
              }
            }
          }
        });
        emit(RankingLoaded(teamsData: teams));
      });
    });
  }
}

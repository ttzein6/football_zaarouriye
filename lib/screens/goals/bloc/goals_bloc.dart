import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nede_fetyen/models/player_model.dart';
import 'package:nede_fetyen/services/database_services.dart';

part 'goals_event.dart';
part 'goals_state.dart';

class GoalsBloc extends Bloc<GoalsEvent, GoalsState> {
  List<Player> players = [];
  GoalsBloc() : super(GoalsInitial()) {
    on<GetGoalsData>((event, emit) async {
      emit(GoalsLoading());
      await Database().getPlayersData().then((value) {
        players = value!;
        players.sort(((a, b) => a.goals.compareTo(b.goals)));
        players = players.reversed.toList();
        emit(GoalsLoaded(playersData: players));
      });
    });
  }
}

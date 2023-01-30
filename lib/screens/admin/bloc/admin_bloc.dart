import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nede_fetyen/models/match_model.dart';
import 'package:nede_fetyen/models/player_model.dart';
import 'package:nede_fetyen/models/teams_model.dart';
import 'package:nede_fetyen/services/database_services.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(AdminInitial()) {
    on<GetPlayersData>((event, emit) async {
      emit(AdminLoading());
      await Database().getPlayersData().then((players) async {
        await Database().getTeamsData().then(
          (teams) async {
            await Database().getMatchesData().then((matches) {
              emit(AdminLoaded(
                  players: players!, teams: teams!, matches: matches!));
            });
          },
        );
      });
    });
  }
}

part of 'admin_bloc.dart';

@immutable
abstract class AdminState {}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class AdminLoaded extends AdminState {
  List<Player> players;
  List<Team> teams;
  List<Match> matches;
  AdminLoaded(
      {required this.players, required this.teams, required this.matches});
}

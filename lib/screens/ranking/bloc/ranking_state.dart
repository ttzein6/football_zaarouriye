part of 'ranking_bloc.dart';

@immutable
abstract class RankingState {}

class RankingInitial extends RankingState {}

class RankingLoading extends RankingState {}

class RankingLoaded extends RankingState {
  List<Team> teamsData;
  RankingLoaded({required this.teamsData});
}

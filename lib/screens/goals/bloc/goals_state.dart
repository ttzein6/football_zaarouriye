part of 'goals_bloc.dart';

@immutable
abstract class GoalsState {}

class GoalsInitial extends GoalsState {}

class GoalsLoading extends GoalsState {}

class GoalsLoaded extends GoalsState {
  final List<Player> playersData;
  GoalsLoaded({required this.playersData});
}

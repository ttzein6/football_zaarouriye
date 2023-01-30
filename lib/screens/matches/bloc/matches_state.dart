// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'matches_bloc.dart';

@immutable
abstract class MatchesState {}

class MatchesInitial extends MatchesState {}

class MatchesLoading extends MatchesState {}

class MatchesLoaded extends MatchesState {
  final List<Match> matchesData;
  final Map<String, List<Match>> weekMatchesMap;
  final List<String> weeks;
  MatchesLoaded({
    required this.matchesData,
    required this.weekMatchesMap,
    required this.weeks,
  });
}

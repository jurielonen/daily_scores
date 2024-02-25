import 'package:freezed_annotation/freezed_annotation.dart';

import '../name_model.dart';
import 'period_descriptor.dart';

part 'scoring.freezed.dart';
part 'scoring.g.dart';

@freezed
class Scoring with _$Scoring {
  const factory Scoring({
    required List<GameScoring> goals,
    required PeriodDescriptor periodDescriptor,
  }) = _Scoring;

  factory Scoring.fromJson(Map<String, dynamic> json) =>
      _$ScoringFromJson(json);
}

@freezed
class GameScoring with _$GameScoring {
  const factory GameScoring({
    required NameModel name,
    required String? headshot,
    required NameModel teamAbbrev,
    required int goalsToDate,
    required String? shotType,
    required String strength,
    required String timeInPeriod,
    required int homeScore,
    required int awayScore,
    required NameModel? leadingTeamAbbrev,
    @Default([]) List<GameAssists> assists,
  }) = _GameScoring;

  factory GameScoring.fromJson(Map<String, dynamic> json) =>
      _$GameScoringFromJson(json);
}

@freezed
class GameAssists with _$GameAssists {
  const factory GameAssists({
    required NameModel name,
    required int assistsToDate,
  }) = _GameAssists;

  factory GameAssists.fromJson(Map<String, dynamic> json) =>
      _$GameAssistsFromJson(json);
}

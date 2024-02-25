import 'package:freezed_annotation/freezed_annotation.dart';

import 'game/game.dart';

part 'day_scores.freezed.dart';
part 'day_scores.g.dart';

@freezed
class DayScores with _$DayScores {
  const DayScores._();
  const factory DayScores({
    required DateTime currentDate,
    required DateTime nextDate,
    required DateTime prevDate,
    @Default([]) List<Game> games,
  }) = _DayScores;

  factory DayScores.fromJson(Map<String, dynamic> json) =>
      _$DayScoresFromJson(json);

  @override
  String toString() {
    return 'DayScores(currentDate: $currentDate, nextDate: $nextDate, prevDate: $prevDate, games: ${games.length})';
  }
}

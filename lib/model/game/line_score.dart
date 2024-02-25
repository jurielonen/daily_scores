import 'package:freezed_annotation/freezed_annotation.dart';

import 'stats_by_period.dart';

part 'line_score.freezed.dart';
part 'line_score.g.dart';

@freezed
class LineScore with _$LineScore {
  const factory LineScore({required List<StatsByPeriod> byPeriod}) = _LineScore;

  factory LineScore.fromJson(Map<String, dynamic> json) =>
      _$LineScoreFromJson(json);
}

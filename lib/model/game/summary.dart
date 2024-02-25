import 'package:freezed_annotation/freezed_annotation.dart';

import 'scoring.dart';
import 'stats_by_period.dart';

part 'summary.freezed.dart';
part 'summary.g.dart';

@freezed
class Summary with _$Summary {
  const factory Summary({
    required List<Scoring> scoring,
    @_LineScoreConverter() required List<StatsByPeriod> linescore,
    required List<StatsByPeriod> shotsByPeriod,
  }) = _Summary;

  factory Summary.fromJson(Map<String, dynamic> json) =>
      _$SummaryFromJson(json);
}

class _LineScoreConverter
    extends JsonConverter<List<StatsByPeriod>, Map<String, dynamic>> {
  const _LineScoreConverter();

  @override
  List<StatsByPeriod> fromJson(Map<String, dynamic> json) =>
      (json['byPeriod'] as List<dynamic>)
          .map((e) => StatsByPeriod.fromJson(e as Map<String, dynamic>))
          .toList();

  @override
  Map<String, dynamic> toJson(List<StatsByPeriod> object) => {
        'byPeriod': [
          for (var item in object) {'name': item}
        ]
      };
}

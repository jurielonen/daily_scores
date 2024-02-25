import 'package:freezed_annotation/freezed_annotation.dart';

import 'period_descriptor.dart';

part 'stats_by_period.freezed.dart';
part 'stats_by_period.g.dart';

@freezed
class StatsByPeriod with _$StatsByPeriod {
  const factory StatsByPeriod({
    required PeriodDescriptor periodDescriptor,
    required int home,
    required int away,
  }) = _StatsByPeriod;

  factory StatsByPeriod.fromJson(Map<String, dynamic> json) =>
      _$StatsByPeriodFromJson(json);
}

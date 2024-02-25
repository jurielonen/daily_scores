import 'package:freezed_annotation/freezed_annotation.dart';

import 'schedule_day.dart';

part 'schedule.freezed.dart';
part 'schedule.g.dart';

@freezed
class Schedule with _$Schedule {
  const factory Schedule({
    required DateTime nextStartDate,
    required DateTime previousStartDate,
    @Default([]) List<ScheduleDay> gameWeek,
  }) = _Schedule;

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);
}

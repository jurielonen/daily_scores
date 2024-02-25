import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_day.freezed.dart';
part 'schedule_day.g.dart';

@freezed
class ScheduleDay with _$ScheduleDay {
  const factory ScheduleDay({
    required DateTime date,
    required String dayAbbrev,
    required int numberOfGames,
  }) = _ScheduleDay;

  factory ScheduleDay.fromJson(Map<String, dynamic> json) =>
      _$ScheduleDayFromJson(json);
}

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../api/stats_api.dart';
import '../model/schedule.dart';
import '../utils/date_time_extension.dart';

part 'schedule_bloc.freezed.dart';

@Injectable()
class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  @visibleForTesting
  static const Duration subtractionFromStartDate = Duration(hours: 12);

  final StatsAPI _statsAPI;
  ScheduleBloc(this._statsAPI) : super(const ScheduleState.loading()) {
    on<ScheduleEvent>((event, emit) async {
      await event.when(get: (date) async {
        emit(const ScheduleState.loading());
        date ??= DateUtils.dateOnly(
            DateTime.now().subtract(subtractionFromStartDate));
        try {
          final schedule =
              await _statsAPI.getSchedule(date: date.toApiFormat());
          emit(
            ScheduleState.loaded(
              schedule,
              date,
            ),
          );
        } catch (error, stack) {
          emit(ScheduleState.error(error, stack, date));
        }
      });
    });
    add(const ScheduleEvent.get());
  }
}

@freezed
class ScheduleState with _$ScheduleState {
  const factory ScheduleState.loading() = _ScheduleLoading;
  const factory ScheduleState.loaded(Schedule schedule, DateTime date) =
      _ScheduleLoaded;
  const factory ScheduleState.error(
    Object error,
    StackTrace stack,
    DateTime? date,
  ) = _ScheduleError;
}

@freezed
class ScheduleEvent with _$ScheduleEvent {
  const factory ScheduleEvent.get({DateTime? date}) = _ScheduleGet;
}

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../api/stats_api.dart';
import '../model/day_scores.dart';
import '../utils/date_time_extension.dart';

part 'day_scores_bloc.freezed.dart';

@Injectable()
class DayScoresBloc extends Bloc<DayScoresEvent, DayScoresState> {
  final StatsAPI _statsAPI;
  DayScoresBloc(this._statsAPI, @factoryParam DateTime date)
      : super(const DayScoresState.loading()) {
    on<DayScoresEvent>((event, emit) async {
      await event.when(
        get: (date) async {
          emit(const DayScoresState.loading());
          return _getScores(date, emit);
        },
        refresh: (date) {
          return _getScores(date, emit);
        },
      );
    });
    add(DayScoresEvent.get(date: date));
  }

  Future<void> _getScores(DateTime date, Emitter<DayScoresState> emit) async {
    try {
      final score = await _statsAPI.getScores(date: date.toApiFormat());
      emit(
        DayScoresState.loaded(
          score,
        ),
      );
    } catch (error, stack) {
      emit(DayScoresState.error(error, stack, date));
    }
  }
}

@freezed
class DayScoresState with _$DayScoresState {
  const factory DayScoresState.loading() = _DayScoresLoading;
  const factory DayScoresState.loaded(DayScores scores) = _DayScoresLoaded;
  const factory DayScoresState.error(
    Object error,
    StackTrace stack,
    DateTime date,
  ) = _DayScoresError;
}

@freezed
class DayScoresEvent with _$DayScoresEvent {
  const factory DayScoresEvent.get({required DateTime date}) = _DayScoresGet;
  const factory DayScoresEvent.refresh({required DateTime date}) =
      _DayScoresRefresh;
}

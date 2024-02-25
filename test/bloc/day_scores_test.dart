import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:daily_scores/api/stats_api.dart';
import 'package:daily_scores/bloc/day_scores_bloc.dart';
import 'package:daily_scores/model/day_scores.dart';
import 'package:daily_scores/model/game/game.dart';
import 'package:daily_scores/utils/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../test_helpers.dart';
import 'day_scores_test.mocks.dart';

@GenerateNiceMocks([MockSpec<StatsAPI>()])
void main() {
  final MockStatsAPI mockAPI = MockStatsAPI();
  buildDayScoresBloc(DateTime dateTime) => DayScoresBloc(mockAPI, dateTime);

  setUpMocksValid() {
    when(mockAPI.getScores(
      date: anyNamed('date'),
    )).thenAnswer(
      (realInvocation) async => getDayScores(
          DateTime.parse(realInvocation.namedArguments.values.first)),
    );
  }

  noMoreInteractions() {
    TestHelpers.noMoreInteractions([mockAPI]);
  }

  tearDown() {
    TestHelpers.resetMocks([mockAPI]);
  }

  dayScoresBlocTest(
    String description, {
    required DateTime initialDate,
    FutureOr<void> Function()? setUp,
    dynamic Function(DayScoresBloc bloc)? act,
    dynamic Function()? expect,
    dynamic Function(DayScoresBloc bloc)? verify,
  }) {
    blocTest<DayScoresBloc, DayScoresState>(
      description,
      build: () => buildDayScoresBloc(initialDate),
      setUp: setUp,
      act: act,
      expect: expect,
      verify: (bloc) {
        verify?.call(bloc);
        noMoreInteractions();
      },
      tearDown: tearDown,
    );
  }

  group('DayScoresBloc', () {
    dayScoresBlocTest(
      'Gets automatically given days scores',
      initialDate: initialDate,
      setUp: setUpMocksValid,
      expect: () => [
        const DayScoresState.loading(),
        DayScoresState.loaded(getDayScores(initialDate)),
      ],
      verify: (bloc) {
        verify(mockAPI.getScores(date: initialDate.toApiFormat())).called(1);
      },
    );

    dayScoresBlocTest(
      'Gets given dates scores',
      initialDate: initialDate,
      setUp: setUpMocksValid,
      act: (bloc) => bloc.add(DayScoresEvent.get(date: getDate)),
      expect: () => [
        const DayScoresState.loading(),
        DayScoresState.loaded(getDayScores(initialDate)),
        const DayScoresState.loading(),
        DayScoresState.loaded(getDayScores(getDate)),
      ],
      verify: (bloc) {
        verify(mockAPI.getScores(date: initialDate.toApiFormat())).called(1);
        verify(mockAPI.getScores(date: getDate.toApiFormat())).called(1);
      },
    );

    dayScoresBlocTest(
      'Refresh given dates scores without adding loaded state',
      initialDate: initialDate,
      setUp: () {
        int callCount = 0;
        when(mockAPI.getScores(
          date: anyNamed('date'),
        )).thenAnswer(
          (realInvocation) async => getDayScores(
              DateTime.parse(realInvocation.namedArguments.values.first)
                  .add(Duration(
            hours: callCount++,
          ))),
        );
      },
      act: (bloc) => bloc.add(DayScoresEvent.refresh(date: initialDate)),
      expect: () => [
        const DayScoresState.loading(),
        DayScoresState.loaded(getDayScores(initialDate)),
        DayScoresState.loaded(
            getDayScores(initialDate.add(const Duration(hours: 1)))),
      ],
      verify: (bloc) {
        verify(mockAPI.getScores(date: initialDate.toApiFormat())).called(2);
      },
    );

    dayScoresBlocTest(
      'emits DayScoresState.error when an error occurs',
      initialDate: initialDate,
      setUp: () => when(mockAPI.getScores(date: initialDate.toApiFormat()))
          .thenThrow(TestHelpers.testException),
      expect: () => [
        const DayScoresState.loading(),
        isA<DayScoresState>(),
      ],
      verify: (bloc) {
        verify(mockAPI.getScores(date: initialDate.toApiFormat())).called(1);
        bloc.state.when(
          loading: () => fail(
              'Wrong state ${bloc.state.runtimeType} when supposed to be ScheduleError'),
          loaded: (_) => fail(
              'Wrong state ${bloc.state.runtimeType} when supposed to be ScheduleError'),
          error: (error, _, date) {
            expect(error, TestHelpers.testException);
            expect(date, initialDate);
          },
        );
      },
    );
  });
}

final DateTime initialDate = DateUtils.dateOnly(DateTime.now());
final DateTime getDate =
    DateUtils.dateOnly(DateTime.now().add(const Duration(days: 12)));

DayScores getDayScores(DateTime dateTime, {List<Game>? games}) {
  return DayScores(
    currentDate: dateTime,
    nextDate: dateTime.add(const Duration(days: 1)),
    prevDate: dateTime.subtract(const Duration(days: 1)),
    games: games ?? [],
  );
}

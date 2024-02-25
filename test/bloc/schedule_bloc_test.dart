import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:daily_scores/api/stats_api.dart';
import 'package:daily_scores/bloc/schedule_bloc.dart';
import 'package:daily_scores/model/schedule.dart';
import 'package:daily_scores/utils/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../test_helpers.dart';
import 'schedule_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<StatsAPI>()])
void main() {
  final MockStatsAPI mockAPI = MockStatsAPI();

  buildScheduleBloc() => ScheduleBloc(mockAPI);

  DateTime? currentDate;

  setUpMocksValid() {
    when(mockAPI.getSchedule(
      date: startDate.toApiFormat(),
    )).thenAnswer((realInvocation) async {
      currentDate = DateTime.parse(realInvocation.namedArguments.values.first);
      return getSchedule(currentDate!);
    });
  }

  noMoreInteractions() {
    TestHelpers.noMoreInteractions([mockAPI]);
  }

  tearDown() {
    TestHelpers.resetMocks([mockAPI]);
    currentDate = null;
  }

  scheduleBlocTest(
    String description, {
    FutureOr<void> Function()? setUp,
    dynamic Function(ScheduleBloc bloc)? act,
    dynamic Function()? expect,
    dynamic Function(ScheduleBloc bloc)? verify,
  }) {
    blocTest<ScheduleBloc, ScheduleState>(
      description,
      build: buildScheduleBloc,
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

  group('ScheduleBloc', () {
    scheduleBlocTest(
      'Gets automatically current dates - 12h schedule from StatsAPI',
      setUp: setUpMocksValid,
      expect: () => [
        const ScheduleState.loading(),
        getLoadedState(currentDate!),
      ],
      verify: (bloc) {
        expect(
          currentDate,
          startDate,
        );
        verify(mockAPI.getSchedule(date: currentDate!.toApiFormat())).called(1);
      },
    );

    scheduleBlocTest(
      'Gets new schedule when ScheduleEvent.get added',
      setUp: () {
        setUpMocksValid();
        when(mockAPI.getSchedule(date: getDate.toApiFormat())).thenAnswer(
          (realInvocation) async => getSchedule(getDate),
        );
      },
      act: (bloc) => bloc.add(ScheduleEvent.get(date: getDate)),
      expect: () => [
        const ScheduleState.loading(),
        getLoadedState(currentDate!),
        const ScheduleState.loading(),
        getLoadedState(getDate),
      ],
      verify: (bloc) {
        verify(mockAPI.getSchedule(date: currentDate!.toApiFormat())).called(1);
        verify(mockAPI.getSchedule(date: getDate.toApiFormat())).called(1);
      },
    );

    scheduleBlocTest(
      'Sets error state if StatsAPI throws error',
      setUp: () => when(mockAPI.getSchedule(date: anyNamed('date')))
          .thenThrow(TestHelpers.testException),
      expect: () => [
        const ScheduleState.loading(),
        isA<ScheduleState>(),
      ],
      verify: (bloc) {
        verify(mockAPI.getSchedule(date: startDate.toApiFormat())).called(1);
        bloc.state.when(
          loading: () => fail(
              'Wrong state ${bloc.state.runtimeType} when supposed to be ScheduleError'),
          loaded: (_, __) => fail(
              'Wrong state ${bloc.state.runtimeType} when supposed to be ScheduleError'),
          error: (error, _, date) {
            expect(error, TestHelpers.testException);
            expect(date, startDate);
          },
        );
      },
    );
  });
}

final DateTime startDate = DateUtils.dateOnly(
  DateTime.now().subtract(ScheduleBloc.subtractionFromStartDate),
);

final DateTime getDate = DateTime.now().subtract(const Duration(days: 24));

Schedule getSchedule(DateTime currentDate) {
  return Schedule(
    nextStartDate: DateUtils.dateOnly(currentDate.add(const Duration(days: 7))),
    previousStartDate:
        DateUtils.dateOnly(currentDate.subtract(const Duration(days: 7))),
  );
}

ScheduleState getLoadedState(DateTime currentDate) {
  return ScheduleState.loaded(
    getSchedule(currentDate),
    currentDate,
  );
}

import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:daily_scores/api/stats_api.dart';
import 'package:daily_scores/bloc/game_bloc.dart';
import 'package:daily_scores/model/game/game.dart';
import 'package:daily_scores/model/team.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../test_helpers.dart';
import 'game_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<StatsAPI>()])
void main() {
  final MockStatsAPI mockAPI = MockStatsAPI();

  buildGameBloc(int id) => GameBloc(mockAPI, id);

  setUpMocksValid() {
    when(mockAPI.getGameLanding(
      id: anyNamed('id'),
    )).thenAnswer(
      (realInvocation) async =>
          getGame(realInvocation.namedArguments.values.first),
    );
  }

  noMoreInteractions() {
    TestHelpers.noMoreInteractions([mockAPI]);
  }

  tearDown() {
    TestHelpers.resetMocks([mockAPI]);
  }

  gameBlocTest(
    String description, {
    required int initialId,
    FutureOr<void> Function()? setUp,
    dynamic Function(GameBloc bloc)? act,
    dynamic Function()? expect,
    dynamic Function(GameBloc bloc)? verify,
  }) {
    blocTest<GameBloc, GameBlocState>(
      description,
      build: () => buildGameBloc(initialId),
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

  group('GameBloc', () {
    gameBlocTest(
      'Gets automatically given ids game',
      initialId: id,
      setUp: setUpMocksValid,
      expect: () => [
        const GameBlocState.loading(id),
        GameBlocState.loaded(
          id,
          getGame(id),
        ),
      ],
      verify: (bloc) {
        verify(mockAPI.getGameLanding(id: id)).called(id);
      },
    );

    gameBlocTest(
      'emits GameBlocState.error when an error occurs',
      initialId: id,
      setUp: () => when(mockAPI.getGameLanding(id: id))
          .thenThrow(TestHelpers.testException),
      expect: () => [
        const GameBlocState.loading(id),
        isA<GameBlocState>(),
      ],
      verify: (bloc) {
        verify(mockAPI.getGameLanding(id: id)).called(id);
        bloc.state.when(
          loading: (id) => fail(
              'Wrong state ${bloc.state.runtimeType} when supposed to be GameBlocError'),
          loaded: (_, __) => fail(
              'Wrong state ${bloc.state.runtimeType} when supposed to be GameBlocError'),
          error: (error, _, errorId) {
            expect(error, TestHelpers.testException);
            expect(errorId, id);
          },
        );
      },
    );
  });
}

const id = 1;

Game getGame(int id) => Game(
    id: id,
    startTimeUTC: DateUtils.dateOnly(DateTime.now()),
    homeTeam: getTeam(id + 1),
    awayTeam: getTeam(id + 2),
    gameState: GameState.finished,
    clock: null,
    periodDescriptor: null,
    gameOutcome: null);

Team getTeam(int id) => Team(
      id: id,
      abbrev: 'abbrev',
      logo: 'logo',
      score: null,
      record: null,
      sog: null,
    );

import 'package:freezed_annotation/freezed_annotation.dart';

import '../team.dart';
import 'period_descriptor.dart';
import 'summary.dart';

part 'game.freezed.dart';
part 'game.g.dart';

enum GameState {
  @JsonValue('OFF')
  official,
  @JsonValue('FINAL')
  finished,
  @JsonValue('PRE')
  preGame,
  @JsonValue('LIVE')
  live,
  @JsonValue('CRIT')
  critical,
  @JsonValue('FUT')
  future,
  @JsonValue('UNKNOWN')
  unknown
}

@freezed
class Game with _$Game {
  const factory Game({
    required int id,
    required DateTime startTimeUTC,
    required Team homeTeam,
    required Team awayTeam,
    // ignore: invalid_annotation_target
    @JsonKey(unknownEnumValue: GameState.unknown) required GameState gameState,
    required GameClock? clock,
    required PeriodDescriptor? periodDescriptor,
    required GameOutcome? gameOutcome,
    Summary? summary,
  }) = _Game;

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
}

@freezed
class GameOutcome with _$GameOutcome {
  const factory GameOutcome({
    required String lastPeriodType,
  }) = _GameOutcome;

  factory GameOutcome.fromJson(Map<String, dynamic> json) =>
      _$GameOutcomeFromJson(json);
}

@freezed
class GameClock with _$GameClock {
  const factory GameClock({
    required bool inIntermission,
    required bool running,
    required int secondsRemaining,
    required String timeRemaining,
  }) = _GameClock;

  factory GameClock.fromJson(Map<String, dynamic> json) =>
      _$GameClockFromJson(json);
}

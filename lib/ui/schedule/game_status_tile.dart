import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/intl_strings.dart';

import '../../model/game/game.dart';
import '../../theme/app_dimensions.dart';
import '../../theme/app_text.dart';
import '../../theme/spacer.dart';

class GameStatusTile extends StatelessWidget {
  final Game game;
  const GameStatusTile({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    final strings = IntlStrings.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    final colors = switch (game.gameState) {
      GameState.unknown ||
      GameState.future ||
      GameState.finished ||
      GameState.official =>
        (
          background: null,
          text: colorScheme.onBackground,
        ),
      GameState.preGame || GameState.live => (
          background: colorScheme.primary,
          text: colorScheme.onPrimary,
        ),
      GameState.critical => (
          background: colorScheme.error,
          text: colorScheme.onError,
        ),
    };

    final child = switch (game.gameState) {
      GameState.unknown => Text(strings.gameStatusUnknown.toUpperCase()),
      GameState.future => Text(
          strings
              .gameStatusScheduled(game.startTimeUTC.toLocal())
              .toUpperCase(),
        ),
      GameState.preGame => Text(strings.gameStatusStarting),
      GameState.finished || GameState.official => finished(strings),
      GameState.live || GameState.critical => live(strings, colors.text),
    };

    return DefaultTextStyle(
      style: AppText.textExtraSmall700.copyWith(color: colors.text),
      child: Container(
        decoration: BoxDecoration(
            color: colors.background,
            borderRadius: BorderRadius.circular(
              AppDimensions.spacingXSmall,
            )),
        padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.spacingXSmall,
          horizontal: AppDimensions.spacingSmall,
        ),
        child: child,
      ),
    );
  }

  Widget finished(IntlStrings strings) {
    String text = strings.gameStatusFinal;
    final periodType = game.periodDescriptor?.periodType;
    if (periodType != null && periodType != 'REG') {
      text += '/$periodType';
    }
    return Text(text.toUpperCase());
  }

  Widget live(IntlStrings strings, Color textColor) {
    final clock = game.clock;
    final periodDescriptor = game.periodDescriptor;
    if (clock != null && periodDescriptor != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            strings
                .gamePeriod(
                  periodDescriptor.number.toString(),
                )
                .toUpperCase(),
          ),
          HSpacer.small,
          Text(
            clock.timeRemaining,
            style: AppText.textExtraSmall,
          )
        ],
      );
    }
    return Text(strings.gameStatusLive);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/intl_strings.dart';

import '../../model/game/game.dart';
import '../../theme/app_text.dart';
import '../../theme/spacer.dart';
import '../../utils/widget_utils.dart';

class GameAppBar extends StatelessWidget {
  final Game game;
  const GameAppBar({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.medium(
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: title(context),
      ),
    );
  }

  Widget title(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DefaultTextStyle(
      style: AppText.headingMedium700.copyWith(
        color: colorScheme.onPrimary,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          WidgetUtils.teamLogo(game.homeTeam),
          Text(game.homeTeam.score?.toString() ?? ''),
          HSpacer.small,
          gameStatus(context),
          HSpacer.small,
          Text(game.awayTeam.score?.toString() ?? ''),
          WidgetUtils.teamLogo(game.awayTeam),
        ],
      ),
    );
  }

  Widget gameStatus(BuildContext context) {
    final strings = IntlStrings.of(context);
    final text = switch (game.gameState) {
      GameState.unknown => strings.gameStatusUnknown,
      GameState.future => strings.gameAppBarDate(game.startTimeUTC.toLocal()),
      GameState.finished || GameState.official => strings.gameStatusFinal,
      GameState.preGame => strings.gameStatusStarting,
      GameState.live || GameState.critical => strings.gameStatusLive,
    };
    Widget widget = Text(
      text,
      style: AppText.gameAppBarStateTitle,
    );

    return switch (game.gameState) {
      GameState.unknown => widget,
      GameState.future => gameStatusWithChild(
          widget, strings.gameAppBarTime(game.startTimeUTC.toLocal())),
      GameState.finished || GameState.official => widget,
      GameState.preGame => widget,
      GameState.live ||
      GameState.critical =>
        gameStatusWithChild(widget, game.clock?.timeRemaining ?? ''),
    };
  }

  Widget gameStatusWithChild(Widget child, String text) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        child,
        Text(
          text,
          style: AppText.gameAppBarStateDesc,
        )
      ],
    );
  }
}

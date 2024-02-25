import 'package:flutter/material.dart';

import '../../model/game/game.dart';
import '../../model/team.dart';
import '../../router/app_router.dart';
import '../../theme/app_text.dart';
import '../../theme/spacer.dart';
import '../../utils/widget_utils.dart';
import '../widget/pressable_container.dart';
import 'game_status_tile.dart';

class GameTile extends StatelessWidget {
  final Game game;
  const GameTile({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PressableContainer(
        onTap: () => GameRoute(id: game.id).go(context),
        backgroundColor: Colors.black38,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VSpacer.small,
              GameStatusTile(game: game),
              VSpacer.small,
              teamRow(game.homeTeam, colorScheme),
              VSpacer.small,
              teamRow(game.awayTeam, colorScheme),
              VSpacer.small,
            ],
          ),
        ),
      ),
    );
  }

  Widget teamRow(Team team, ColorScheme colorScheme) {
    final teamScore = team.score;
    return Row(
      children: [
        WidgetUtils.teamLogo(team),
        HSpacer.small,
        Expanded(
          child: Text(
            team.abbrev,
            style: AppText.textMedium700,
          ),
        ),
        if (teamScore != null)
          Text(
            teamScore.toString(),
            style: AppText.textMedium700,
          )
      ],
    );
  }
}

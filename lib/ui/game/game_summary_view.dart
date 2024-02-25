import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/intl_strings.dart';

import '../../model/game/game.dart';
import '../../model/game/scoring.dart';
import '../../model/game/summary.dart';
import '../../theme/app_dimensions.dart';
import '../../theme/app_text.dart';
import '../../theme/spacer.dart';
import '../widget/stats_by_period_table.dart';
import 'game_app_bar.dart';
import 'goal_tile.dart';
import 'period_tile.dart';

class GameSummaryView extends StatelessWidget {
  final Game game;
  const GameSummaryView({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    final strings = IntlStrings.of(context);
    final summary = game.summary;
    return CustomScrollView(
      slivers: [
        GameAppBar(
          game: game,
        ),
        if (summary != null) ...showGameSummary(strings, summary),
      ],
    );
  }

  List<Widget> showGameSummary(
    IntlStrings strings,
    Summary summary,
  ) {
    return [
      sliverTitle(strings.gameLineScoreTitle),
      SliverToBoxAdapter(
        child: StatsByPeriodTable(
          stats: summary.linescore,
          homeTeam: game.homeTeam,
          awayTeam: game.awayTeam,
        ),
      ),
      sliverTitle(strings.gameShotsByPeriodTitle),
      SliverToBoxAdapter(
        child: StatsByPeriodTable(
          stats: summary.shotsByPeriod,
          homeTeam: game.homeTeam,
          awayTeam: game.awayTeam,
        ),
      ),
      sliverTitle(strings.gameScoringPlaysTitle),
      scoringPlaysList(strings, summary.scoring),
      VSpacer.sliverXLarge,
    ];
  }

  Widget scoringPlaysList(
    IntlStrings strings,
    List<Scoring> scoring,
  ) {
    return SliverList.list(
      children: scoring
          .map((e) => [
                PeriodTile(period: e.periodDescriptor),
                ...e.goals.map((goal) => GoalTile(
                      goal: goal,
                    ))
              ])
          .expand((element) => element)
          .toList(),
    );
  }

  Widget sliverTitle(String text) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        left: AppDimensions.spacingMedium,
        top: AppDimensions.spacingMedium,
      ),
      sliver: SliverToBoxAdapter(
        child: Text(
          text.toUpperCase(),
          style: AppText.headingSmall700,
        ),
      ),
    );
  }
}

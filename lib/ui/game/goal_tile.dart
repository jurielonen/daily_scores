import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/intl_strings.dart';

import '../../model/game/scoring.dart';
import '../../theme/app_dimensions.dart';
import '../../theme/app_text.dart';
import '../../utils/widget_utils.dart';

class GoalTile extends StatelessWidget {
  final GameScoring goal;
  const GoalTile({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    final strings = IntlStrings.of(context);
    return Column(
      children: [
        goalListTile(strings),
        gameStateRow(strings),
        const Divider(
          indent: AppDimensions.spacingSmall,
          endIndent: AppDimensions.spacingSmall,
        ),
      ],
    );
  }

  Widget goalListTile(IntlStrings strings) {
    return ListTile(
      leading: WidgetUtils.networkImage(goal.headshot),
      title: Text(
        strings.scoring(goal.name.value ?? '', goal.goalsToDate),
        style: AppText.textMedium700,
      ),
      subtitle: assists(strings),
    );
  }

  Widget assists(IntlStrings strings) {
    return Text(
      goal.assists
          .map((assist) =>
              strings.scoring(assist.name.value ?? '', assist.assistsToDate))
          .join(', '),
      style: AppText.textSmall,
    );
  }

  Widget gameStateRow(IntlStrings strings) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppDimensions.spacingMedium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          gameStateBox(
            strings.shot.toUpperCase(),
            '${goal.homeScore}-${goal.awayScore} ${goal.leadingTeamAbbrev?.value ?? ''}'
                .toUpperCase(),
          ),
          gameStateBox(
            strings.shot.toUpperCase(),
            (goal.shotType ?? '').toUpperCase(),
          ),
          gameStateBox(
            strings.time.toUpperCase(),
            goal.timeInPeriod.toUpperCase(),
          ),
          gameStateBox(
            strings.strength.toUpperCase(),
            goal.strength.toUpperCase(),
          ),
        ],
      ),
    );
  }

  Widget gameStateBox(String title, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppText.textExtraSmall700.copyWith(color: Colors.white54),
        ),
        Text(
          value,
          style: AppText.textExtraSmall700,
        ),
      ],
    );
  }
}

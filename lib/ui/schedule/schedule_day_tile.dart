import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/intl_strings.dart';

import '../../model/schedule_day.dart';
import '../../theme/app_dimensions.dart';
import '../../theme/app_text.dart';
import '../widget/pressable_container.dart';

class ScheduleDayTile extends StatelessWidget {
  final ScheduleDay day;
  final bool selected;
  final Function(ScheduleDay) onPressed;
  const ScheduleDayTile({
    super.key,
    required this.day,
    required this.onPressed,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    final strings = IntlStrings.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final backgroundColor = selected ? colorScheme.primary : null;
    final textColor = selected ? colorScheme.onPrimary : null;

    return PressableContainer(
        onTap: () => onPressed(day),
        backgroundColor: backgroundColor,
        borderRadius: null,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.spacingSmall,
            horizontal: AppDimensions.spacingMedium,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                day.dayAbbrev,
                style: AppText.textExtraSmall.copyWith(color: textColor),
              ),
              Text(
                strings.scheduleDayDate(day.date),
                style: AppText.textMedium700.copyWith(color: textColor),
              ),
              Text(
                day.numberOfGames.toString(),
                style: AppText.textExtraSmall.copyWith(color: textColor),
              ),
            ],
          ),
        ));
  }
}

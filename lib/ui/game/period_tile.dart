import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/intl_strings.dart';

import '../../model/game/period_descriptor.dart';
import '../../theme/app_dimensions.dart';
import '../../theme/app_text.dart';

class PeriodTile extends StatelessWidget {
  final PeriodDescriptor period;
  const PeriodTile({super.key, required this.period});

  @override
  Widget build(BuildContext context) {
    final strings = IntlStrings.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          color: Colors.white38,
          thickness: AppDimensions.spacingSmall,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.spacingSmall,
            horizontal: AppDimensions.spacingMedium,
          ),
          child: Text(
            strings.gamePeriodWithPeriod(period.number.toString()),
            style: AppText.headingSmall700,
          ),
        ),
      ],
    );
  }
}

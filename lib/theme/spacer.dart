import 'package:flutter/material.dart';

import 'app_dimensions.dart';

class VSpacer {
  static Widget get small => const SizedBox(
        height: AppDimensions.spacingSmall,
      );

  static Widget get medium => const SizedBox(
        height: AppDimensions.spacingMedium,
      );

  static Widget get sliverXLarge => const SliverToBoxAdapter(
        child: SizedBox(
          height: AppDimensions.spacingXLarge,
        ),
      );
}

class HSpacer {
  static Widget get small => const SizedBox(
        width: AppDimensions.spacingSmall,
      );

  static Widget get medium => const SizedBox(
        width: AppDimensions.spacingMedium,
      );
}

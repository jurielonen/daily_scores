import 'package:flutter/material.dart';

import 'app_dimensions.dart';

class VSpacer {
  static Widget get small => const SizedBox(
        height: AppDimensions.spacingSmall,
      );

  static Widget get medium => const SizedBox(
        height: AppDimensions.spacingMedium,
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

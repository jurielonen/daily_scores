import 'package:flutter/material.dart';

class AppText {
  static TextTheme theme() => TextTheme(
        displayLarge: headingLarge700,
        displayMedium: headingMedium700,
        displaySmall: headingSmall700,
        headlineLarge: headingLarge500,
        headlineMedium: headingMedium500,
        headlineSmall: headingSmall500,
        titleLarge: headingLarge,
        titleMedium: headingMedium,
        titleSmall: headingSmall,
        bodyLarge: textLarge500,
        bodyMedium: textMedium500,
        bodySmall: textSmall500,
        labelLarge: textLarge,
        labelMedium: textMedium,
        labelSmall: textSmall,
      );
  static const TextStyle defaultTextStyle = TextStyle(fontFamily: 'Roboto');

  static final TextStyle headingLarge = defaultTextStyle.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 30,
    height: 1.2,
  );

  static final TextStyle headingLarge500 = headingLarge.copyWith(
    fontWeight: FontWeight.w500,
  );

  static final TextStyle headingLarge700 = headingLarge.copyWith(
    fontWeight: FontWeight.w700,
  );

  static final TextStyle headingMedium = defaultTextStyle.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 24,
    height: 1.33,
  );

  static final TextStyle headingMedium500 = headingMedium.copyWith(
    fontWeight: FontWeight.w500,
  );

  static final TextStyle headingMedium700 = headingMedium.copyWith(
    fontWeight: FontWeight.w700,
  );

  static final TextStyle headingSmall = defaultTextStyle.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 20,
    height: 1.2,
  );

  static final TextStyle headingSmall500 = headingSmall.copyWith(
    fontWeight: FontWeight.w500,
  );

  static final TextStyle headingSmall700 = headingSmall.copyWith(
    fontWeight: FontWeight.w700,
  );

  static final TextStyle textLarge = defaultTextStyle.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 18,
    height: 1.5,
  );

  static final TextStyle textLarge500 = textLarge.copyWith(
    fontWeight: FontWeight.w500,
  );

  static final TextStyle textMedium = defaultTextStyle.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.5,
  );

  static final TextStyle textMedium500 = textMedium.copyWith(
    fontWeight: FontWeight.w500,
  );

  static final TextStyle textMedium700 = textMedium.copyWith(
    fontWeight: FontWeight.w700,
  );

  static final TextStyle textSmall = defaultTextStyle.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.43,
  );

  static final TextStyle textSmall500 = textSmall.copyWith(
    fontWeight: FontWeight.w500,
  );

  static final TextStyle textSmall700 = textSmall.copyWith(
    fontWeight: FontWeight.w700,
  );

  static final TextStyle textExtraSmall = defaultTextStyle.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 1.33,
  );

  static final TextStyle textExtraSmall700 = textExtraSmall.copyWith(
    fontWeight: FontWeight.w700,
  );

  static final TextStyle gameAppBarStateTitle = defaultTextStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 10,
    height: 1.33,
  );

  static final TextStyle gameAppBarStateDesc = gameAppBarStateTitle.copyWith(
    fontWeight: FontWeight.w400,
  );
}

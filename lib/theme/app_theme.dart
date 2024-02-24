import "package:flutter/material.dart";
import "package:flutter/services.dart";

import "app_text.dart";

/// Generated with Figma plugin [Material Theme Builder](https://www.figma.com/community/plugin/1034969338659738588/material-theme-builder)
class AppTheme {
  static ColorScheme darkColorScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff91d5ac),
      surfaceTint: Color(0xff91d5ac),
      onPrimary: Color(0xff003921),
      primaryContainer: Color(0xff045233),
      onPrimaryContainer: Color(0xffadf2c7),
      secondary: Color(0xffb5ccbb),
      onSecondary: Color(0xff203529),
      secondaryContainer: Color(0xff374b3e),
      onSecondaryContainer: Color(0xffd0e8d6),
      tertiary: Color(0xffa4cddc),
      onTertiary: Color(0xff043542),
      tertiaryContainer: Color(0xff224c59),
      onTertiaryContainer: Color(0xffbfe9f9),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff0f1511),
      onBackground: Color(0xffdfe4dd),
      surface: Color(0xff0f1511),
      onSurface: Color(0xffdfe4dd),
      surfaceVariant: Color(0xff404942),
      onSurfaceVariant: Color(0xffc0c9c0),
      outline: Color(0xff8a938b),
      outlineVariant: Color(0xff404942),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdfe4dd),
      onInverseSurface: Color(0xff2c322d),
      inversePrimary: Color(0xff276a49),
    );
  }

  static ThemeData theme({ColorScheme? colorScheme, TextTheme? textTheme}) {
    colorScheme ??= darkColorScheme();
    textTheme ??= AppText.theme();
    return ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
          ),
        ));
  }
}

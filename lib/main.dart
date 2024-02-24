import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/intl_strings.dart';
import 'package:go_router/go_router.dart';

import 'di/di.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupDI();

  runApp(const DailyScoresApp());
}

class DailyScoresApp extends StatelessWidget {
  const DailyScoresApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      onGenerateTitle: (context) => IntlStrings.of(context).appName,
      localizationsDelegates: IntlStrings.localizationsDelegates,
      supportedLocales: IntlStrings.supportedLocales,
      theme: AppTheme.theme(),
      routerConfig: di<GoRouter>(),
    );
  }
}

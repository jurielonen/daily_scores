import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/intl_strings.dart';
import 'package:go_router/go_router.dart';

import 'bloc/app_bloc_observer.dart';
import 'di/di.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupDI();

  if (kDebugMode) {
    Bloc.observer = AppBlocObserver();
  }
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

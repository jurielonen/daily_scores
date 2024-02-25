import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../api/stats_api.dart';
import '../router/app_router.dart';

@module
abstract class AppModule {
  @singleton
  GoRouter get router => GoRouter(
        debugLogDiagnostics: kDebugMode,
        routes: $appRoutes,
      );

  @Named('StatsUrl')
  @lazySingleton
  String get statsUrl => const String.fromEnvironment("STATS_URL");

  @lazySingleton
  StatsAPI statsAPI(@Named('StatsUrl') String baseUrl) => StatsAPI(
        Dio(),
        baseUrl: baseUrl,
      );
}

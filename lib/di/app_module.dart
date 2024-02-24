import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../router/app_router.dart';

@module
abstract class AppModule {
  @singleton
  GoRouter get router => GoRouter(
        debugLogDiagnostics: kDebugMode,
        routes: $appRoutes,
      );
}

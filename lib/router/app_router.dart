import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/schedule/schedule_page.dart';

part 'app_router.g.dart';

@TypedGoRoute<ScheduleRoute>(path: '/')
class ScheduleRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SchedulePage();
}

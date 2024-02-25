import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/game/game_page.dart';
import '../ui/schedule/schedule_page.dart';

part 'app_router.g.dart';

@TypedGoRoute<ScheduleRoute>(path: '/', routes: [
  TypedGoRoute<GameRoute>(path: 'game/:id'),
])
class ScheduleRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SchedulePage();
}

class GameRoute extends GoRouteData {
  final int id;

  GameRoute({required this.id});
  @override
  Widget build(BuildContext context, GoRouterState state) => GamePage(id: id);
}

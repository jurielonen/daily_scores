import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../model/day_scores.dart';
import '../model/game/game.dart';
import '../model/schedule.dart';

part 'stats_api.g.dart';

@RestApi()
abstract class StatsAPI {
  factory StatsAPI(Dio dio, {required String baseUrl}) = _StatsAPI;

  static const schedulePath = '/v1/schedule/{date}';
  static const scoresPath = '/v1/score/{date}';
  static const gamePath = '/v1/gamecenter/{id}/landing';

  @GET(schedulePath)
  Future<Schedule> getSchedule({@Path() required String date});

  @GET(scoresPath)
  Future<DayScores> getScores({@Path() required String date});

  @GET(gamePath)
  Future<Game> getGameLanding({@Path() required int id});
}

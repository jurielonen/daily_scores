import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../model/day_scores.dart';
import '../model/schedule.dart';

part 'stats_api.g.dart';

@RestApi()
abstract class StatsAPI {
  factory StatsAPI(Dio dio, {required String baseUrl}) = _StatsAPI;

  static const schedulePath = '/v1/schedule/{date}';
  static const scoresPath = '/v1/score/{date}';

  @GET(schedulePath)
  Future<Schedule> getSchedule({@Path() required String date});

  @GET(scoresPath)
  Future<DayScores> getScores({@Path() required String date});
}

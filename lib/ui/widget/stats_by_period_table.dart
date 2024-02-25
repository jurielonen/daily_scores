import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/intl_strings.dart';

import '../../model/game/stats_by_period.dart';
import '../../model/team.dart';
import '../../utils/widget_utils.dart';

class StatsByPeriodTable extends StatelessWidget {
  final List<StatsByPeriod> stats;
  final Team homeTeam;
  final Team awayTeam;
  const StatsByPeriodTable(
      {super.key,
      required this.stats,
      required this.homeTeam,
      required this.awayTeam});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(
            label: Container(),
          ),
          ...stats.map(
            (stat) => DataColumn(
              label: Center(
                child: Text(
                  IntlStrings.of(context)
                      .gamePeriod(stat.periodDescriptor.number.toString()),
                ),
              ),
            ),
          ),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Row(children: [
              WidgetUtils.teamLogo(homeTeam),
              Text(homeTeam.abbrev)
            ])),
            ...stats.map(
                (stat) => DataCell(Center(child: Text(stat.home.toString())))),
          ]),
          DataRow(cells: [
            DataCell(Row(children: [
              WidgetUtils.teamLogo(awayTeam),
              Text(awayTeam.abbrev)
            ])),
            ...stats.map(
                (stat) => DataCell(Center(child: Text(stat.away.toString())))),
          ])
        ],
      ),
    );
  }
}

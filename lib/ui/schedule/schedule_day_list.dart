import 'package:flutter/material.dart';

import '../../model/schedule.dart';
import '../../model/schedule_day.dart';
import 'game_list.dart';
import 'schedule_day_tile.dart';

class ScheduleDayList extends StatefulWidget {
  final Schedule schedule;
  final Function(DateTime) onSelected;
  const ScheduleDayList({
    super.key,
    required this.schedule,
    required this.onSelected,
  });

  @override
  State<ScheduleDayList> createState() => _ScheduleDayListState();
}

class _ScheduleDayListState extends State<ScheduleDayList> {
  late ScheduleDay _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.schedule.gameWeek.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        scheduleDayList(),
        Expanded(
          child: GameListView(
            selectedDate: _selectedDay.date,
          ),
        ),
      ],
    );
  }

  Widget scheduleDayList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black38,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.background,
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            IconButton(
              onPressed: () =>
                  widget.onSelected(widget.schedule.previousStartDate),
              icon: const Icon(
                Icons.navigate_before,
              ),
            ),
            ...widget.schedule.gameWeek.map(
              (day) => ScheduleDayTile(
                day: day,
                selected: day == _selectedDay,
                onPressed: (selected) =>
                    setState(() => _selectedDay = selected),
              ),
            ),
            IconButton(
              onPressed: () => widget.onSelected(widget.schedule.nextStartDate),
              icon: const Icon(
                Icons.navigate_next,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

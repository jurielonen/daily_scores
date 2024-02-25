import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/intl_strings.dart';

import '../../bloc/schedule_bloc.dart';
import '../../di/di.dart';
import '../../utils/widget_utils.dart';
import '../widget/error_box.dart';
import '../widget/loading_widget.dart';
import 'schedule_day_list.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.emptyAppBar(),
      body: SafeArea(
        child: BlocProvider<ScheduleBloc>(
          create: (_) => di<ScheduleBloc>(),
          child: const ScheduleWidget(),
        ),
      ),
    );
  }
}

class ScheduleWidget extends StatelessWidget {
  const ScheduleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      builder: (context, state) {
        final bloc = context.read<ScheduleBloc>();
        return state.when(
          loading: () =>
              LoadingWidget(msg: IntlStrings.of(context).scheduleLoading),
          error: (error, stackTrace, date) => ErrorBox(
            error: error,
            stackTrace: stackTrace,
            tryAgain: () => bloc.add(
              ScheduleEvent.get(date: date),
            ),
          ),
          loaded: (schedule, date) => ScheduleDayList(
            schedule: schedule,
            onSelected: (date) => bloc.add(
              ScheduleEvent.get(date: date),
            ),
          ),
        );
      },
    );
  }

  Widget loadingWidget(IntlStrings strings) {
    return LoadingWidget(msg: strings.scheduleLoading);
  }

  Widget errorWidget(BuildContext context, Object error, StackTrace stackTrace,
      DateTime? date) {
    return ErrorBox(
      error: error,
      stackTrace: stackTrace,
      tryAgain: () => context.read<ScheduleBloc>().add(
            ScheduleEvent.get(date: date),
          ),
    );
  }
}

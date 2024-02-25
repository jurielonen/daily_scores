import 'package:daily_scores/ui/game/game_summary_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/intl_strings.dart';

import '../../bloc/game_bloc.dart';
import '../../di/di.dart';
import '../../utils/widget_utils.dart';
import '../widget/error_box.dart';
import '../widget/loading_widget.dart';

class GamePage extends StatelessWidget {
  final int id;
  const GamePage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.emptyAppBar(),
      body: SafeArea(
        child: BlocProvider<GameBloc>(
          create: (_) => di<GameBloc>(param1: id),
          child: const GameWidget(),
        ),
      ),
    );
  }
}

class GameWidget extends StatelessWidget {
  const GameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = IntlStrings.of(context);
    return BlocBuilder<GameBloc, GameBlocState>(builder: (context, state) {
      final bloc = context.read<GameBloc>();
      return state.when(
        loading: (id) => LoadingWidget(msg: strings.scheduleLoading),
        error: (error, stackTrace, date) => ErrorBox(
          error: error,
          stackTrace: stackTrace,
          tryAgain: () => bloc.add(const GameEvent.get()),
        ),
        loaded: (id, game) {
          return GameSummaryView(game: game);
        },
      );
    });
  }
}

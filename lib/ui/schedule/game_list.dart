import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/intl_strings.dart';

import '../../bloc/day_scores_bloc.dart';
import '../../di/di.dart';
import '../../model/day_scores.dart';
import '../../theme/app_dimensions.dart';
import '../widget/error_box.dart';
import '../widget/loading_widget.dart';
import 'game_tile.dart';

class GameListView extends StatefulWidget {
  final DateTime selectedDate;
  const GameListView({super.key, required this.selectedDate});

  @override
  State<GameListView> createState() => _GameListViewState();
}

class _GameListViewState extends State<GameListView> {
  late final DayScoresBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = di<DayScoresBloc>(param1: widget.selectedDate);
  }

  @override
  void didUpdateWidget(GameListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!DateUtils.isSameDay(oldWidget.selectedDate, widget.selectedDate)) {
      bloc.add(DayScoresEvent.get(date: widget.selectedDate));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DayScoresBloc>(
      create: (_) => bloc,
      child: const GameListWidget(),
    );
  }
}

class GameListWidget extends StatelessWidget {
  const GameListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DayScoresBloc, DayScoresState>(
      builder: (context, state) {
        final bloc = context.read<DayScoresBloc>();
        return state.when(
          loading: () => LoadingWidget(
            msg: IntlStrings.of(context).gameListLoading,
          ),
          error: (error, stackTrace, date) => ErrorBox(
            error: error,
            stackTrace: stackTrace,
            tryAgain: () => bloc.add(
              DayScoresEvent.get(date: date),
            ),
          ),
          loaded: (scores) => GameList(
            scores: scores,
            refresh: () => bloc.add(
              DayScoresEvent.refresh(date: scores.currentDate),
            ),
          ),
        );
      },
    );
  }
}

class GameList extends StatelessWidget {
  final DayScores scores;
  final VoidCallback refresh;
  const GameList({
    super.key,
    required this.scores,
    required this.refresh,
  });

  @override
  Widget build(BuildContext context) {
    final games = scores.games;
    if (games.isEmpty) {
      Text(
        IntlStrings.of(context).gameListNoGames,
      );
    }

    return RefreshIndicator(
      onRefresh: () async => refresh(),
      child: ListView.builder(
        padding:
            const EdgeInsets.symmetric(vertical: AppDimensions.spacingXLarge),
        itemCount: games.length,
        itemBuilder: (context, index) {
          final game = games[index];
          return GameTile(game: game);
        },
      ),
    );
  }
}

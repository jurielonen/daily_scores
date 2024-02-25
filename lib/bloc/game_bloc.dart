import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../api/stats_api.dart';
import '../model/game/game.dart';

part 'game_bloc.freezed.dart';

@Injectable()
class GameBloc extends Bloc<GameEvent, GameBlocState> {
  final StatsAPI _statsAPI;
  GameBloc(this._statsAPI, @factoryParam int id)
      : super(GameBlocState.loading(id)) {
    on<GameEvent>((event, emit) async {
      await event.when(
        get: () async {
          emit(GameBlocState.loading(state.id));
          try {
            final game = await _statsAPI.getGameLanding(id: state.id);
            emit(GameBlocState.loaded(state.id, game));
          } catch (error, stack) {
            emit(GameBlocState.error(error, stack, state.id));
          }
        },
      );
    });
    add(const GameEvent.get());
  }
}

@freezed
class GameBlocState with _$GameBlocState {
  const factory GameBlocState.loading(int id) = _GameBlocLoading;
  const factory GameBlocState.loaded(int id, Game game) = _GameBlocLoaded;
  const factory GameBlocState.error(
    Object error,
    StackTrace stack,
    int id,
  ) = _GameBlocError;
}

@freezed
class GameEvent with _$GameEvent {
  const factory GameEvent.get() = _GameGet;
}

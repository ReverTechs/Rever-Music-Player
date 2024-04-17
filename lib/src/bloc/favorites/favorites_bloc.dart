import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:rever/src/data/repositories/favorites_repository.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc({required FavoritesRepository repository})
      : super(FavoritesInitial()) {
    on<FetchFavorites>((event, emit) async {
      emit(FavoritesLoading());
      try {
        final favoriteSongs = await repository.fetchFavorites();
        emit(FavoritesLoaded(favoriteSongs));
      } catch (e) {
        emit(FavoritesError(e.toString()));
      }
    });
  }
}

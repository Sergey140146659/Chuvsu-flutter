import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/data/services/favorites_service_interface.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc(this.favoritesService) : super(FavoritesInitial()) {
    on<FavoritesLoad>(_onLoad);
    on<FavoritesAdd>(_onAdd);
    on<FavoritesRemove>(_onRemove);
  }

  final FavoritesServiceInterface favoritesService;

  Future<void> _onLoad(
    FavoritesLoad event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      emit(FavoritesLoading());
      final favorites = await favoritesService.getFavorites();
      emit(FavoritesLoaded(favoriteIds: favorites));
    } catch (e) {
      emit(FavoritesFailure(error: e.toString()));
    }
  }

  Future<void> _onAdd(
    FavoritesAdd event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await favoritesService.addFavorite(event.modelId);
      final favorites = await favoritesService.getFavorites();
      emit(FavoritesLoaded(favoriteIds: favorites));
    } catch (e) {
      emit(FavoritesFailure(error: e.toString()));
    }
  }

  Future<void> _onRemove(
    FavoritesRemove event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await favoritesService.removeFavorite(event.modelId);
      final favorites = await favoritesService.getFavorites();
      emit(FavoritesLoaded(favoriteIds: favorites));
    } catch (e) {
      emit(FavoritesFailure(error: e.toString()));
    }
  }
}

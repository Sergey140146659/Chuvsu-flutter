part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class FavoritesLoad extends FavoritesEvent {}

class FavoritesAdd extends FavoritesEvent {
  const FavoritesAdd({required this.modelId});

  final String modelId;

  @override
  List<Object?> get props => [modelId];
}

class FavoritesRemove extends FavoritesEvent {
  const FavoritesRemove({required this.modelId});

  final String modelId;

  @override
  List<Object?> get props => [modelId];
}

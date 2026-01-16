part of 'favorites_bloc.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  const FavoritesLoaded({required this.favoriteIds});

  final List<String> favoriteIds;

  @override
  List<Object?> get props => [favoriteIds];
}

class FavoritesFailure extends FavoritesState {
  const FavoritesFailure({required this.error});

  final String error;

  @override
  List<Object?> get props => [error];
}

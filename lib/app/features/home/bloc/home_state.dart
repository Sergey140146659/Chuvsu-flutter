part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class ModelsListLoading extends HomeState {}

class ModelsListLoaded extends HomeState {
  const ModelsListLoaded({required this.modelsList});
  final List<ModelInfo> modelsList;

  @override
  List<Object?> get props => [modelsList];
}

class ModelsListLoadingFailure extends HomeState {
  const ModelsListLoadingFailure({required this.exception});
  final Object exception;

  @override
  List<Object?> get props => [exception];
}

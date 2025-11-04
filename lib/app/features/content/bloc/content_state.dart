part of 'content_bloc.dart';

abstract class ContentState extends Equatable {
  const ContentState();

  @override
  List<Object> get props => [];
}

class ContentInitial extends ContentState {}

class ModelDetailsLoading extends ContentState {}

class ModelDetailsLoaded extends ContentState {
  const ModelDetailsLoaded({required this.model});
  final ModelInfo model;

  @override
  List<Object> get props => [model];
}

class ModelDetailsLoadingFailure extends ContentState {
  const ModelDetailsLoadingFailure({required this.exception});
  final Object exception;

  @override
  List<Object> get props => [exception];
}

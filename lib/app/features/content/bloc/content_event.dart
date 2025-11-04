part of 'content_bloc.dart';

abstract class ContentEvent extends Equatable {
  const ContentEvent();

  @override
  List<Object> get props => [];
}

class LoadModelDetails extends ContentEvent {
  const LoadModelDetails({required this.modelId});
  final String modelId;

  @override
  List<Object> get props => [modelId];
}

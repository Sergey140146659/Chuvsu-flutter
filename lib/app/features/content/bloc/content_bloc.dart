import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:flutter_application_1/data/repositories/models/model_info.dart';
import 'package:flutter_application_1/data/repositories/models_repository_interface.dart';

part 'content_event.dart';
part 'content_state.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  ContentBloc(this.modelsRepository, this.talker) : super(ContentInitial()) {
    on<LoadModelDetails>(_load);
  }

  final ModelsRepositoryInterface modelsRepository;
  final Talker talker;

  Future<void> _load(
    LoadModelDetails event,
    Emitter<ContentState> emit,
  ) async {
    try {
      emit(ModelDetailsLoading());
      final model = await modelsRepository.getModelDetails(event.modelId);
      emit(ModelDetailsLoaded(model: model));
    } catch (e, st) {
      emit(ModelDetailsLoadingFailure(exception: e));
      talker.handle(e, st);
    }
  }
}

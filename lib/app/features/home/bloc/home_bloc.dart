import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:flutter_application_1/data/repositories/models/model_info.dart';
import 'package:flutter_application_1/data/repositories/models_repository_interface.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.modelsRepository, this.talker) : super(HomeInitial()) {
    on<LoadModelsList>(_load);
  }

  final ModelsRepositoryInterface modelsRepository;
  final Talker talker;

  Future<void> _load(
    LoadModelsList event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(ModelsListLoading());
      final models = await modelsRepository.getModelsList();
      emit(ModelsListLoaded(modelsList: models));
    } catch (e, st) {
      emit(ModelsListLoadingFailure(exception: e));
      talker.handle(e, st);
    }
  }
}

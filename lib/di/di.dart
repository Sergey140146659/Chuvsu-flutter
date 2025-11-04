import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/data/dio/set_up.dart';
import 'package:flutter_application_1/app/features/home/bloc/home_bloc.dart';
import 'package:flutter_application_1/data/repositories/models_repository.dart';
import 'package:flutter_application_1/data/repositories/models_repository_interface.dart';
final getIt = GetIt.instance;
final talker = TalkerFlutter.init();
final dio = Dio();

Future<void> setupLocator() async {
  getIt.registerSingleton(talker);
  talker.info('Talker started...');

  setUpDio(dio);
  getIt.registerSingleton(dio);

  getIt.registerLazySingleton<ModelsRepositoryInterface>(
    () => ModelsRepository(dio: getIt<Dio>()),
  );

  getIt.registerFactory<HomeBloc>(
    () => HomeBloc(
      getIt<ModelsRepositoryInterface>(),
      getIt<Talker>(),
    ),
  );
}

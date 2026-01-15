import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/data/dio/set_up.dart';
import 'package:flutter_application_1/app/features/home/bloc/home_bloc.dart';
import 'package:flutter_application_1/data/repositories/models_repository.dart';
import 'package:flutter_application_1/data/repositories/models_repository_interface.dart';
import 'package:flutter_application_1/app/features/content/bloc/content_bloc.dart';
import 'package:flutter_application_1/data/services/auth_service.dart';
import 'package:flutter_application_1/data/services/auth_service_interface.dart';
import 'package:flutter_application_1/app/features/register/bloc/register_bloc.dart';
import 'package:flutter_application_1/app/features/login/bloc/login_bloc.dart';

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

  getIt.registerLazySingleton<AuthServiceInterface>(
    () => AuthService(),
  );

  getIt.registerFactory<HomeBloc>(
    () => HomeBloc(
      getIt<ModelsRepositoryInterface>(),
      getIt<Talker>(),
    ),
  );

  getIt.registerFactory<ContentBloc>(
    () => ContentBloc(
      getIt<ModelsRepositoryInterface>(),
      getIt<Talker>(),
    ),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(getIt<AuthServiceInterface>()),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(getIt<AuthServiceInterface>()),
  );
}

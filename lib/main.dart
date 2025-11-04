import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_name.dart';
import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  FlutterError.onError = (details) {
    return talker.handle(details.exception, details.stack);
  };

  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      printStateFullData: false,
      printEventFullData: false,
    ),
  );

  runApp(const AppName());
}

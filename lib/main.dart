import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_name.dart';
import 'package:flutter_application_1/di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  FlutterError.onError = (details) {
    return talker.handle(details.exception, details.stack);
  };

  runApp(const AppName());
}
